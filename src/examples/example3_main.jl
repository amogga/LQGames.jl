include("../algorithms/plotting.jl")
include("example3/example3.jl")
include("example3/objective_function.jl")
include("example3/players.jl")

using .Example3
using .Plotting

states = [-2, -30.0, pi / 2.0 , 4.0,
          -10, 45, -(pi / 2.0), 3.0,
          -11, 16.0, 0.0, 1.25]
input = [0,0,0,0,0,0.0]

iterations = overall_solver(states,input; iterations_count=80, sample=0.05, maxtime=10)

println(total_cost_for_players_per_iteration(iterations[8]))

build_position_animation_from_iteration(last(iterations); file="src/examples/example3/animation.gif")