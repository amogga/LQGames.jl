module Quadratization
	include("../structs/quadratized_cost.jl")
	include("../types/basic.jl")

	using ForwardDiff: gradient, hessian

	export quadratize_costs_for_players

	function quadratize_costs_for_players(totalcost, players, states::Vector{Float64}, input::Vector{Float64})
		qs = []; ls = []; rss = [];
		for p in players
			cost = quadratize_cost_for_player(totalcost, p, states, input)
			push!(qs,cost.Q)
			push!(ls,cost.l)
			push!(rss,cost.Rs)
		end
		return QuadratizedMultiCost(qs,ls,rss)
	end

	function quadratize_cost_for_player(totalcost, player, states::Vector{Float64}, input::Vector{Float64})
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