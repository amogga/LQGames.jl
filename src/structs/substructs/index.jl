struct StateIndexT1
	position::Vector{Int}
	psi::Int
	velocity::Int
	all_positions::Vector{Vector{Int}}
end

struct InputIndexT1
	all_inputs::Vector{Vector{Int}}
	angular_velocity::Int
	acceleration::Int
end

struct InputIndexT2
	all_inputs::Vector{Vector{Int}}
	steering_angle::Int
	acceleration::Int
end