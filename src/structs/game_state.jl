struct LQGameState 
	Zs::Vector{Matrix{Float64}}
	zetas::Vector{Vector{Float64}}
end

struct PAlphaPair 
	P::Matrix{Float64}
	α::Vector{Float64}
end