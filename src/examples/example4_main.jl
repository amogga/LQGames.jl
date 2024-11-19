include("../algorithms/plotting.jl")
include("example4/example4.jl")
include("example4/objective_function.jl")
include("example4/players.jl")

using .Example4
using .Plotting

states = [-2, -30.0, pi / 2.0 , 4.0,
          -10, 45, -(pi / 2.0), 3.0,
          -11, 16.0, 0.0, 1.25]
input = [0,0,0,0,0,0.0]

iterations = overall_solver(states,input; iterations_count=150, sample=0.1, maxtime=12)

println(total_cost_for_players_per_iteration(iterations[8]))

build_position_animation_from_iteration(last(iterations); file="src/examples/example4/animation.gif")