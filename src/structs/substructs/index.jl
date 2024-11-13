struct StateIndexT1
	position::Vector{Int}
	psi::Int
	velocity::Int
	all_positions::Vector{Vector{Int}}
end

struct InputIndexT1
	angular_velocity::Int
	acceleration::Int
	all_inputs::Vector{Vector{Int}}
end

struct InputIndexT2
	steering_angle::Int
	acceleration::Int
	all_inputs::Vector{Vector{Int}}
end