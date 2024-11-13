struct CostInfoT1
	goal_position::Vector{Float64}
	min_velocity::Float64
	max_velocity::Float64
	nom_velocity::Float64
	proximity::Float64
	polyline::Vector{Vector{Float64}}
	polyline_boundary::Float64
end


struct CostInfoT2
	goal_position::Vector{Float64}
	min_velocity::Float64
	max_velocity::Float64
	nom_velocity::Float64
	proximity::Float64
end


struct CostInfoT3
	nom_velocity::Float64
	proximity::Float64
	polyline::Vector{Vector{Float64}}
	polyline_boundary::Float64
end


struct CostInfoT4
	nom_velocity::Float64
	nom_heading::Float64
	proximity::Float64
	polyline::Vector{Vector{Float64}}
	polyline_boundary::Float64
end
