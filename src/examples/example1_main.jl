include("example1/example1.jl")
include("example1/objective_function.jl")
include("example1/players.jl")
include("../solver/lq_game.jl")
include("../structs/game_state.jl")
using .Example1
using .LQGameSolver
using BenchmarkTools
using ForwardDiff


states = [6.5, 0.0, pi / 2.0 , 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
input = [0,0,0,0,0,0.0]

iterCount = 60
iterations = overall_solver(states,input,iterCount)

println(total_cost_for_players_per_iteration(last(iterations)))

plot_positions_from_iteration(last(iterations))