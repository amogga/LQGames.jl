module ODESolve
	using DifferentialEquations
	
	export nonlinear_solve

	function nonlinear_solve(sys,xi,u,t)
		problem = ODEProblem(sys, xi, (0,t),u)
		solve(problem, RK4())(t)
	end
end