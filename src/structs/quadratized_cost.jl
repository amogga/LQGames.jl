struct QuadratizedCost
	Q::Matrix{Float64}
	l::Vector{Float64}
	Rs::Vector{Matrix{Float64}}
end

struct QuadratizedMultiCost
	Qs::Vector{Matrix{Float64}}
	ls::Vector{Vector{Float64}}
	Rss::Vector{Vector{Matrix{Float64}}}
end