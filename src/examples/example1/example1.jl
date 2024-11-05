module Example1
	include("players.jl")
	include("../../dynamics/model.jl")
	include("../../dynamics/linearization.jl")
	include("../../dynamics/discretization.jl")
	include("../../dynamics/ode_solve.jl")
	include("objective_function.jl")
	include("../../objective_function/quadratization.jl")
	
	using .Quadratization
	using .Linearization
	using .Discretization
	using .ODESolve

	function quadratize_costs(states::Vector{Float64}, input::Vector{Float64})
		map(p -> quadratize(obj_func, p, states, input), players)
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
		linearize_discretize(nonlinear_dynamics,x,u)
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

	export quadratize_costs, discrete_linear_dynamics, solve_nonlinear_dynamics, generate_initial_state_response
end