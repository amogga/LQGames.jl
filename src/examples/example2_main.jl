include("../algorithms/plotting.jl")
include("example2/example2.jl")
include("example2/objective_function.jl")
include("example2/players.jl")

using .Example2
using .Plotting

states = [2.5, -10.0, pi / 2.0 , 5.0, 
		 -1.0, -10.0, pi / 2.0, 5.0, 
		 2.5, 10.0, pi / 2.0, 5.25]
input = [0,0,0,0,0,0.0]

iterations = overall_solver(states,input; iterations_count=60, sample=0.25, maxtime=5)

println(total_cost_for_players_per_iteration(last(iterations)))

plot_positions_from_iteration(last(iterations))