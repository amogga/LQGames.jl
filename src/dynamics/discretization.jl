module Discretization
	using LinearAlgebra
	include("../structs/linearized_system.jl")

	export discretize

	function discretize(lin_sys,ts)
		ad = I + ts * lin_sys.A
		bd = ts * lin_sys.B
		LinearizedDiscreteSystem(ad,bd,ts)
	end
end