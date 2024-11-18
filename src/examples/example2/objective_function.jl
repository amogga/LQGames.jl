include("../../objective_function/cost.jl")
include("../../structs/player.jl")
using .Cost

function obj_func(player,states,input)
	stgoul = player.state_cost_weight
	intgoul = player.input_cost_weight

	stgoul.nom_velocity * nom_velocity_cost(player, states) +
	stgoul.nom_heading * nom_heading_cost(player, states) +
	stgoul.polyline * polyline_cost(player, states) + 
	stgoul.polyline_boundary * polyline_boundary_cost(player, states) + 
	stgoul.proximity * proximity_cost(player, states) + 

	# inputs
	intgoul.angular_velocity * input[player.input_index.angular_velocity] ^ 2 + 
	intgoul.acceleration * input[player.input_index.acceleration] ^ 2
end