struct StateCostWeightT1
	goal::Float64
	polyline::Float64
	polyline_boundary::Float64
	min_velocity::Float64
	max_velocity::Float64
	nom_velocity::Float64
	proximity::Float64
end

struct StateCostWeightT2
	goal::Float64
	min_velocity::Float64
	max_velocity::Float64
	nom_velocity::Float64
	proximity::Float64
end

struct InputCostWeightT1
	angular_velocity::Float64
	acceleration::Float64
end

struct InputCostWeightT2
	steering_angle::Float64
	acceleration::Float64
end