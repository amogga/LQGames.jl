module Cost
	include("../algorithms/basic.jl")
	
	using LinearAlgebra

	export goal_cost, 
		   max_velocity_cost, min_velocity_cost, nom_velocity_cost, nom_heading_cost,
		   proximity_cost,
		   polyline_cost, polyline_boundary_cost
	 
	function goal_cost(player, states)
		pos_i = player.state_index.position
		goal_pos = player.cost_info.goal_position
		
		return norm(states[pos_i] - goal_pos)^2
	end

	function max_velocity_cost(player,states)
		vel_i = player.state_index.velocity
		max_vel = player.cost_info.max_velocity

		return max(states[vel_i] - max_vel,0) ^ 2
	end

	function min_velocity_cost(player,states)
		vel_i = player.state_index.velocity
		min_vel = player.cost_info.min_velocity

		return min(states[vel_i] - min_vel,0) ^ 2
	end

	function nom_velocity_cost(player,states)
		vel_i = player.state_index.velocity
		nom_vel = player.cost_info.nom_velocity

		return (states[vel_i] - nom_vel) ^ 2
	end

	function nom_heading_cost(player, states)
		heading_i = player.state_index.psi
		nom_heading = player.cost_info.nom_heading

		return (states[heading_i] - nom_heading) ^ 2
	end

	function polyline_cost(player,states)
		lane_center = player.cost_info.polyline
		ego_pos = states[player.state_index.position]
		return point_line_distance(ego_pos, lane_center)^2
	end

	function polyline_boundary_cost(player,states)
		pline_cost = polyline_cost(player,states)
		pline_boundary_threshold = player.cost_info.polyline_boundary

		return pline_cost > pline_boundary_threshold ? pline_cost : 0
	end

	function proximity_cost(player, states)
		p_ego = player.state_index.position
		p_all = player.state_index.all_positions
		p_others = filter(p_i -> p_i != p_ego, p_all)

		pos_ego = states[p_ego]
		pos_others = map(i->states[i],p_others)
		prox = player.cost_info.proximity

		return pos_others |> 
					(positions -> map(pos_o -> norm(pos_ego - pos_o), positions)) |> 
					(distances -> map(d -> min(d - prox, 0)^2, distances)) |> 
					sum
	end
end