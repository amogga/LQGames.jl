include("../../objective_function/cost.jl")
include("../../structs/player.jl")
using .Cost

function obj_func(player,states,input)
    stgoul = player.state_cost_weight
    intgoul = player.input_cost_weight

    # progress
    stgoul.goal * goal_cost(player, states) +

    # stay in lane
    stgoul.polyline * polyline_cost(player, states) + 
    stgoul.polyline_boundary * polyline_boundary_cost(player, states) + 

    # stay within speed bounds
    stgoul.max_velocity * max_velocity_cost(player, states) + 
    stgoul.min_velocity * min_velocity_cost(player, states) + 

    # avoid collisions
    stgoul.proximity * proximity_cost(player, states) + 

    # penalize inputs: angular velocity and acceleration
    intgoul.angular_velocity * input[player.input_index.angular_velocity] ^ 2 + 
    intgoul.acceleration * input[player.input_index.acceleration] ^ 2
end