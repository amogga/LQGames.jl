include("../../objective_function/cost.jl")
include("../../structs/player.jl")
using .Cost

function obj_func(player,states,input)
	if player isa PlayerT1
		obj_func1(player, states, input)
	else
		obj_func2(player, states, input)
	end
end

function obj_func1(player, states, input)
	stgoul = player.state_cost_weight
	intgoul = player.input_cost_weight

	stgoul.goal * goal_cost(player, states) +
	stgoul.polyline * polyline_cost(player, states) + 
	stgoul.polyline_boundary * polyline_boundary_cost(player, states) + 
	stgoul.max_velocity * max_velocity_cost(player, states) + 
	stgoul.min_velocity * min_velocity_cost(player, states) + 
	stgoul.proximity * proximity_cost(player, states) + 

	# inputs
	intgoul.angular_velocity * input[player.input_index.angular_velocity] ^ 2 + 
	intgoul.acceleration * input[player.input_index.acceleration] ^ 2
end

function obj_func2(player, states, input)
	stgoul = player.state_cost_weight
	intgoul = player.input_cost_weight

	stgoul.goal * goal_cost(player, states) +
	stgoul.max_velocity * max_velocity_cost(player, states) + 
	stgoul.min_velocity * min_velocity_cost(player, states) + 
	stgoul.proximity * proximity_cost(player, states) + 

	# inputs
	intgoul.steering_angle * input[player.input_index.steering_angle] ^ 2 + 
	intgoul.acceleration * input[player.input_index.acceleration] ^ 2
end