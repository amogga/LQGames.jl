module Model
	export car, bicycle

	function car(x,u,_ = nothing)
		_ , _ , Θ , v = x
		w, a = u
		
		[v * cos(Θ),
		 v * sin(Θ),
		 w,
		 a]
	end

	function bicycle(x,u,_ = nothing)
		(lf,lr) = (0.5,0.5)
		_,_,ψ,v = x
		a,δ = u

		β = atan(lr/(lf+lr) * tan(δ))
		
		[v * cos(ψ+β),
		 v * sin(ψ+β),
		 v/lr * sin(β),
		 a]
	end
end