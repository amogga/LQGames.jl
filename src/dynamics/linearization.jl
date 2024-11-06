module Linearization
	include("../structs/linearized_system.jl")
	include("discretization.jl")

	export linearize, linearize_discretize
	using ForwardDiff
	using .Discretization

	function linearize(sys,x,u)
		A = ForwardDiff.jacobian(xv -> sys(xv,u), x)
		B = ForwardDiff.jacobian(uv -> sys(x,uv), u)

		LinearizedSystem(A,B)
	end

	function linearize_discretize(sys,x,u,ts=0.25,t=nothing)
		discretize(linearize(sys,x,u),ts)
	end
end