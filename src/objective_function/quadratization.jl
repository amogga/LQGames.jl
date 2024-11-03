module Quadratization
	include("../structs/quadratized_cost.jl")
	include("../types/basic.jl")

	using ForwardDiff: gradient, hessian

	export quadratize

	function quadratize(totalcost, player, states::Vector{Float64}, input::Vector{Float64})
		sth = state_hessian(totalcost, player, states, input)
		stg = state_gradient(totalcost, player, states, input)
		
		inh = input_hessian(totalcost, player, states, input)
		inhs = map(ini -> inh[ini,ini], player.input_index.all_inputs)
		
		QuadratizedCost(sth,stg,inhs)
	end

	function state_gradient(totalcost,player,states::Vector{Float64},input::Vector{Float64})
		f(x) = totalcost(player, x, input)

		gradient(f, states)
	end


	function state_hessian(totalcost,player,states::Vector{Float64},input::Vector{Float64})
		f(x) = totalcost(player, x, input)

		hessian(f, states)
	end

	function input_hessian(totalcost,player,states::Vector{Float64},input::Vector{Float64})
		f(u) = totalcost(player, states, u)

		hessian(f, input)
	end

end