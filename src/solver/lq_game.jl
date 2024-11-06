module LQGameSolver 
	include("../structs/game_state.jl")

	export solve_lq_game

	function solve_lq_game(lindsystems, lincosts)
		game_state = LQGameState(first(lincosts).Qs, first(lincosts).ls)

		p_alpha = []
		
		for (lind,linc) in zip(lindsystems,lincosts)
			pα = compute_p_α(lind, linc, game_state)
			game_state = update_game_state(lind, linc, game_state, pα)
			pushfirst!(p_alpha, pα)
		end

		return p_alpha
	end

	function compute_s(dynamics, costs, game_state)
		a = dynamics.A
		bs = dynamics.Bs
		rss = costs.Rss
		zs = game_state.Zs
	    nplys = length(bs)

	    s_blocks = [i == j ? 
	    			(rss[i][j] + bs[i]' * zs[i] * bs[i]) :
					bs[i]' * zs[i] * bs[j]
	                for i in 1:nplys, j in 1:nplys
	                ]
	    
	    return reduce(hcat, [reduce(vcat, s_blocks[i, :]) for i in 1:nplys])
	end

	function compute_p(dynamics, game_state, s)
	    # Extract variables from dynamics and game state
	    a = dynamics.A
	    bs = dynamics.Bs
	    zs = game_state.Zs

	    nplys = length(bs)
	    yp_blocks = [bs[i]' * zs[i] * a for i in 1:nplys]
	    yp = reduce(vcat, yp_blocks)  # Concatenate blocks horizontally

	    # Solve the linear system s * p = yp for p
	    p = s \ yp
	    return p
	end

	function compute_α(dynamics, game_state, s)
	    # Extract variables from dynamics and game state
	    bs = dynamics.Bs
	    zetas = game_state.zetas

	    nplys = length(bs)
	    yα_blocks = [bs[i]' * zetas[i] for i in 1:nplys]
	    yα = reduce(vcat, yα_blocks)  # Concatenate blocks horizontally

	    # Solve the linear system s * p = yp for p
	    α = s \ yα
	    return α
	end

	function compute_p_α(dynamics,costs,game_state)
		s = compute_s(dynamics,costs,game_state)
		p = compute_p(dynamics,game_state,s)
		α = compute_α(dynamics,game_state,s)
		return PAlphaPair(p,α)
	end

	function update_game_state(dynamics,costs,game_state,pα)
		a = dynamics.A
	    bs = dynamics.Bs
	    B = reduce(hcat, bs)
	    p = pα.P
	    α = pα.α
	    qs = costs.Qs
	    ls = costs.ls
	    rss = costs.Rss
	    zs = game_state.Zs
	    zetas = game_state.zetas
	    ps(i, j) = partition(i,j,rss,p,1)
		αs(i, j) = partition(i,j,rss,α,2)
		nplys = length(bs)

	    F = a - B * p
	    β = -B * α

	    zsn = [F' * zs[i] * F + qs[i] + sum(ps(i,j)' * rss[i][j] * ps(i,j) for j in 1:nplys) for i in 1:nplys]
	    zetasn = [F' * (zetas[i] + zs[i] * β) + ls[i] + sum(ps(i,j)' * rss[i][j] * αs(i,j) for j in 1:nplys) for i in 1:nplys]
	    return LQGameState(zsn, zetasn)
	end

	function partition(i,j,rss,mat,part)
		startRow = i > 1 ? sum(size(rss[k][j],part) for k in 1:i-1) + 1 : 1
	    endRow = startRow + size(rss[i][j],part) - 1

	    return mat isa Vector ? mat[startRow:endRow] : mat[startRow:endRow, :]
	end
end