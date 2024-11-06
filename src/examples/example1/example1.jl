module Example1
	include("players.jl")
	include("../../dynamics/model.jl")
	include("../../structs/linearized_system.jl")
	include("../../structs/quadratized_cost.jl")
	include("../../dynamics/linearization.jl")
	include("../../dynamics/discretization.jl")
	include("../../dynamics/ode_solve.jl")
	include("objective_function.jl")
	include("../../solver/lq_game.jl")
	include("../../objective_function/quadratization.jl")
	
	using .Quadratization
	using .Linearization
	using .Discretization
	using .ODESolve
	using .LQGameSolver

	function quadratize_costs(states::Vector{Float64}, input::Vector{Float64})
		qs = []; ls = []; rss = [];
		for p in players
			cost = quadratize(obj_func, p, states, input)
			push!(qs,cost.Q)
			push!(ls,cost.l)
			push!(rss,cost.Rs)
		end
		return QuadratizedMultiCost(qs,ls,rss)
	end

	function nonlinear_dynamics(x,u,t=nothing)
	    # Define dynamics functions (similar to dyn in Haskell)
	    dyn = [Model.car, Model.car, Model.bicycle]
	        
	    # Chunk states and controls
	    x_chunks = [x[i:i+3] for i in 1:4:length(x)]
	    u_chunks = [u[i:i+1] for i in 1:2:length(u)]
	    
	    # Apply each function in dyn to its respective (x, u) pair
	    xuv = zip(dyn, zip(x_chunks, u_chunks))
	    results = [f(x, u) for (f, (x, u)) in xuv]
	    
	    # Concatenate results
	    return reduce(vcat, results)
	end

	function discrete_linear_dynamics(x,u)
		lin_sys = linearize_discretize(nonlinear_dynamics,x,u)
		return LinearizedDiscreteMultiSystem(lin_sys.A,[lin_sys.B[:,gp] for gp in [[1,2],[3,4],[5,6]]],lin_sys.sample)
	end

	function solve_nonlinear_dynamics(x,u)
		nonlinear_solve(nonlinear_dynamics,x,u)
	end

	function generate_initial_state_response(x,u)
		results = []
		for _ in 1:20
			push!(results,x)
			x = solve_nonlinear_dynamics(x,u)
		end
		return results
	end

	function solve_state_control(states_list,inputs_list,pα,αscale=0.1)
		xs = []
		us = []
		ps = map(pa_l->pa_l.P,pα)
		αs = map(pa_l->pa_l.α,pα)
		x = first(states_list)

		for (xref,uref,p,α) in zip(states_list,inputs_list,ps,αs)
			push!(xs,x)
			u = uref - p * (x-xref) - αscale * α
			push!(us,u)
			x = solve_nonlinear_dynamics(x,u)
		end

		[xs,us]
	end

	function overall_solver(states,input,iterations_count)
		iter_states, iter_inputs = generate_initial_state_input_pair(states,input)

		iters = [[iter_states, iter_inputs]]
		for _ in 1:iterations_count
			lind, lcosts = compute_reverse_discrete_linear_dynamics_costs(iter_states, iter_inputs)
			p_and_alpha = solve_lq_game(lind, lcosts)
			iter_states, iter_inputs = solve_state_control(iter_states,iter_inputs, p_and_alpha)
			push!(iters,[iter_states, iter_inputs])
		end

		return iters
	end

	function generate_initial_state_input_pair(x,u)
		initial_states = generate_initial_state_response(x,u)
		initial_inputs = [u for _ in 1:20]
		return [initial_states, initial_inputs]
	end

	function compute_reverse_discrete_linear_dynamics_costs(initial_states,initial_inputs)
		rev_initial_states, rev_initial_inputs = map(reverse,[initial_states, initial_inputs])
		lindsystems = map(discrete_linear_dynamics, rev_initial_states, rev_initial_inputs)
		lincosts = map(quadratize_costs, rev_initial_states, rev_initial_inputs)
		return [lindsystems, lincosts]
	end

	function total_cost_for_players(states,input)
		map(p -> obj_func(p,states,input),[car1,car2,bicycle])
	end

	function total_cost_for_players_per_iteration(iteration)
		x,u = iteration
		return reduce(vcat,sum(map(total_cost_for_players,x,u),dims=1))
	end

	

	export total_cost_for_players_per_iteration, solve_nonlinear_dynamics, generate_initial_state_input_pair, compute_reverse_discrete_linear_dynamics_costs, overall_solver
end