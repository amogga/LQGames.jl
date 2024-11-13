module Simulation
	include("../dynamics/ode_solve.jl")
	include("../dynamics/linearization.jl")
	include("../objective_function/quadratization.jl")
	include("../solver/lq_game.jl")

	using .ODESolve
	using .Linearization
	using .Quadratization
	using .LQGameSolver

	export total_cost_for_players_per_iteration

	# Initial states input generation
	function generate_initial_state_response_with_horizon(x,u; instant, horizon, mpl_sys)
		results = []
		nonlinear_ode_solver(x,u) = nonlinear_solve(mpl_sys,x,u,instant)

		for _ in 1:horizon
			push!(results,x)
			x = nonlinear_ode_solver(x, u)
		end

		return results
	end

	function generate_initial_state_response_with_maxtime(x,u; instant, maxtime, mpl_sys)
		results = []
		nonlinear_ode_solver(x,u) = nonlinear_solve(mpl_sys,x,u,instant)

		for _ in 0:instant:(maxtime-instant)
			push!(results,x)
			x = nonlinear_ode_solver(x, u)
		end
		return results
	end

	function generate_initial_state_input_pair_with_maxtime(x,u; instant, maxtime, mpl_sys)
		initial_states = generate_initial_state_response_with_maxtime(x,u,instant=instant,maxtime=maxtime,mpl_sys=mpl_sys)
		initial_inputs = [u for _ in 0:instant:(maxtime-instant)]
		return [initial_states, initial_inputs]
	end

	# Linearization and Quadratization
	function compute_reverse_discrete_linear_dynamics_costs(initial_states, initial_inputs; sample, mpl_sys, pls, objfn)
		rev_initial_states, rev_initial_inputs = map(reverse,[initial_states, initial_inputs])
		lindsystems = map((x,u) -> discrete_linear_dynamics(x,u; sample=sample, mpl_sys=mpl_sys), rev_initial_states, rev_initial_inputs)
		lincosts = map((a,b) -> quadratize_costs_for_players(objfn,pls,a,b), rev_initial_states, rev_initial_inputs)
		return [lindsystems, lincosts]
	end

	# State control simulation
	function solve_state_control(states_list,inputs_list,pα,αscale=0.1;instant,mpl_sys)
		xs = []
		us = []
		ps = map(pa_l->pa_l.P,pα)
		αs = map(pa_l->pa_l.α,pα)
		x = first(states_list)
		nonlinear_ode_solver(x,u) = nonlinear_solve(mpl_sys,x,u,instant)

		for (xref,uref,p,α) in zip(states_list,inputs_list,ps,αs)
			push!(xs,x)
			u = uref - p * (x-xref) - αscale * α
			push!(us,u)
			x = nonlinear_ode_solver(x, u)
		end

		[xs,us]
	end

	# System Dynamics
	function multiplayer_dynamic_system(x, u, t=nothing; dynamic_models, pstate_cnt,pinput_cnt)	        
	    # Chunk states and controls
	    x_chunks = [x[i:i+(pstate_cnt-1)] for i in 1:pstate_cnt:length(x)]
	    u_chunks = [u[i:i+(pinput_cnt-1)] for i in 1:pinput_cnt:length(u)]
	    
	    # Apply each function in dyn to its respective (x, u) pair
	    xuv = zip(dynamic_models, zip(x_chunks, u_chunks))
	    results = [f(x, u) for (f, (x, u)) in xuv]
	    
	    # Concatenate results
	    return reduce(vcat, results)
	end

	# simulation solver
	function overall_solver(states,input; iterations_count, sample, maxtime, mpl_sys, pls, objfn)
		iter_states, iter_inputs = generate_initial_state_input_pair_with_maxtime(states,input; instant=sample, maxtime=maxtime,mpl_sys=mpl_sys)

		iters = [[iter_states, iter_inputs]]
		for _ in 1:iterations_count
			lind, lcosts = compute_reverse_discrete_linear_dynamics_costs(iter_states, iter_inputs; sample=sample, mpl_sys=mpl_sys, pls=pls, objfn=objfn)
			p_and_alpha = solve_lq_game(lind, lcosts)
			iter_states, iter_inputs = solve_state_control(iter_states,iter_inputs, p_and_alpha;instant=sample,mpl_sys=mpl_sys)
			push!(iters,[iter_states, iter_inputs])
		end

		return iters
	end


	# Compute total cost per iteration
	function total_cost_for_players(obj_func,players, states,input)
		map(p -> obj_func(p,states,input),players)
	end

	function total_cost_for_players_per_iteration(obj_func,players,iteration)
		x,u = iteration
		return reduce(vcat,sum(map((a,b) -> total_cost_for_players(obj_func,players,a,b),x,u),dims=1))
	end
end