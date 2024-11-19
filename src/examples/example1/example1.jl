module Example1
include("../../algorithms/simulation.jl")
include("../../dynamics/model.jl")
include("../../objective_function/quadratization.jl")
include("players.jl")
include("objective_function.jl")

export overall_solver, 
quadratize_costs,
total_cost_for_players_per_iteration

# System Dynamics
function multiplayer_dynamic_system(x, u, t=nothing)
    dyn = [Model.car,Model.car,Model.bicycle]
    player_state_count = 4
    player_input_count = 2
    Simulation.multiplayer_dynamic_system(x,u,t; dynamic_models = dyn, pstate_cnt = player_state_count, pinput_cnt = player_input_count)
end

# simulation solver
function overall_solver(states,input; iterations_count, sample, maxtime)
    Simulation.overall_solver(states,input; iterations_count=iterations_count, sample=sample, maxtime=maxtime, mpl_sys=multiplayer_dynamic_system, pls=players, objfn=obj_func)
end

# Quadratization
function quadratize_costs(states::Vector{Float64}, input::Vector{Float64})
    Quadratization.quadratize_costs_for_players(obj_func, players, states, input)
end

# utilities for checking total cost
function total_cost_for_players_per_iteration(iteration)
    Simulation.total_cost_for_players_per_iteration(obj_func,players,iteration)
end
end