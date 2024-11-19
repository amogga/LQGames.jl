include("example1/example1.jl")
include("example1/objective_function.jl")
include("example1/players.jl")
include("../solver/lq_game.jl")
include("../structs/game_state.jl")
include("../algorithms/plotting.jl")
using .Example1
using .LQGameSolver
using .Plotting
using BenchmarkTools
using ForwardDiff
using LinearAlgebra


states = [6.5, 0.0, pi / 2.0 , 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
input = [0,0,0,0,0,0.0]

iterations = overall_solver(states,input; iterations_count=55, sample=0.25, maxtime=5)

println(total_cost_for_players_per_iteration(last(iterations)))

plot_positions_from_iteration(last(iterations))