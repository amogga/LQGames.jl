struct LinearizedSystem 
	sys_matrix::Matrix{Float64}
	inp_matrix::Matrix{Float64}
end

struct LinearizedDiscreteSystem 
	sys_matrix::Matrix{Float64}
	inp_matrix::Matrix{Float64}
	sample::Float64
end