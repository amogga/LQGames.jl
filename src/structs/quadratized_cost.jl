struct QuadratizedCost
	q_matrix::Matrix{Float64}
	l_vector::Vector{Float64}
	r_matrix::Vector{Matrix{Float64}}
end