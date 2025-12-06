include("../algorithms/plotting.jl")
include("example5/example5.jl")
include("example5/objective_function.jl")
include("example5/players.jl")

using .Example5

states = [-2, -30.0, pi / 2.0 , 4.0,
          -10, 45, -(pi / 2.0), 3.0]
input = [0,0,0,0]

iterations = overall_solver(states, input; iterations_count=50, sample=0.25, maxtime=15)


# println(quadratize_costs(states,input).Rss)


# println(map(p -> obj_func(p,states,input),players))

println(map(total_cost_for_players_per_iteration,iterations) |> last)

build_position_animation_from_iteration(last(iterations); file="src/examples/example5/animation.gif")