module Example1
	include("players.jl")
	include("objective_function.jl")
	include("../../objective_function/quadratization.jl")
	
	using .Quadratization

	function quadratize_costs(states::Vector{Float64}, input::Vector{Float64})
		map(p -> quadratize(obj_func, p, states, input), players)
	end

	export car1, car2, bicycle, quadratize_costs
end