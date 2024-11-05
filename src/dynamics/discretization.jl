module Discretization
	using LinearAlgebra
	include("../structs/linearized_system.jl")

	export discretize

	function discretize(linear_sys,ts)
		a = linear_sys.sys_matrix
		b = linear_sys.inp_matrix
		ad = I + ts * a
		bd = ts * b
		LinearizedDiscreteSystem(ad,bd,ts)
	end
end