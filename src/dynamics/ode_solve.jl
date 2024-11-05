module ODESolve
	using DifferentialEquations
	
	export nonlinear_solve

	function nonlinear_solve(sys,xi,u,t=0.25)
		problem = ODEProblem(sys, xi, (0,t),u)
		state_response = solve(problem,RK4())

		state_response(t)
	end
end