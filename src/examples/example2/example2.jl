module Example2
	include("players.jl")
	include("../../algorithms/simulation.jl")
	include("../../dynamics/model.jl")
	include("../../structs/linearized_system.jl")
	include("../../structs/quadratized_cost.jl")
	include("../../dynamics/linearization.jl")
	include("../../dynamics/discretization.jl")
	include("../../dynamics/ode_solve.jl")
	include("objective_function.jl")
	include("../../solver/lq_game.jl")
	include("../../objective_function/quadratization.jl")
	
	using Plots
	using .Quadratization
	using .Linearization
	using .Discretization
	using .ODESolve
	using .LQGameSolver

	export overall_solver, 
		   quadratize_costs,
		   total_cost_for_players_per_iteration

	# System Dynamics
	function multiplayer_dynamic_system(x, u, t=nothing)
		dyn = [Model.car,Model.car,Model.car]
	    Simulation.multiplayer_dynamic_system(x,u,t; dynamic_models = dyn, pstate_cnt = 4, pinput_cnt = 2)
	end

	# simulation solver
	function overall_solver(states,input; iterations_count, sample, maxtime)
		Simulation.overall_solver(states,input; iterations_count=iterations_count, sample=sample, maxtime=maxtime,mpl_sys=multiplayer_dynamic_system,pls=players,objfn = obj_func)
	end

	# Quadratization
	function quadratize_costs(states::Vector{Float64}, input::Vector{Float64})
		quadratize_costs_for_players(obj_func, players, states, input)
	end

	# utilities for checking total cost
	function total_cost_for_players_per_iteration(iteration)
		Simulation.total_cost_for_players_per_iteration(obj_func,players,iteration)
	end
end