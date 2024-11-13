module Linearization
	include("../structs/linearized_system.jl")
	include("discretization.jl")

	export linearize, linearize_discretize, discrete_linear_dynamics
	using ForwardDiff
	using .Discretization

	function linearize(sys,x,u)
		A = ForwardDiff.jacobian(xv -> sys(xv,u), x)
		B = ForwardDiff.jacobian(uv -> sys(x,uv), u)

		LinearizedSystem(A,B)
	end

	function linearize_discretize(sys,x,u,ts,t=nothing)
		discretize(linearize(sys,x,u),ts)
	end

	function discrete_linear_dynamics(x,u; sample, mpl_sys)
		lin_sys = linearize_discretize(mpl_sys, x, u, sample)
		return LinearizedDiscreteMultiSystem(lin_sys.A,[lin_sys.B[:,gp] for gp in [[1,2],[3,4],[5,6]]],lin_sys.sample)
	end
end