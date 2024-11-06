struct LinearizedSystem 
	A::Matrix{Float64}
	B::Matrix{Float64}
end

struct LinearizedDiscreteSystem 
	A::Matrix{Float64}
	B::Matrix{Float64}
	sample::Float64
end

struct LinearizedDiscreteMultiSystem 
	A::Matrix{Float64}
	Bs::Vector{Matrix{Float64}}
	sample::Float64
end