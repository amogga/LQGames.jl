include("example4/example4.jl")
include("example4/objective_function.jl")
include("example4/players.jl")

using .Example4

states = [-2, -30.0, pi / 2.0 , 4.0,
          -10, 45, -(pi / 2.0), 3.0,
          -11, 16.0, 0.0, 1.25]
input = [0,0,0,0,0,0.0]

iterations = overall_solver(states, input; iterations_count=50, sample=0.25, maxtime=15)


# println(quadratize_costs(states,input).Rss)


# println(map(p -> obj_func(p,states,input),players))

println(map(total_cost_for_players_per_iteration,iterations) |> last)