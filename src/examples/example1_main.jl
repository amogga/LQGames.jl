include("./example1/example1.jl")
using .Example1

states = [6.5, 0.0, pi / 2.0 , 1.0, 1.5, 40, -(pi / 2.0), 0.1, 0.0, 22.0, 0.0, 2.0]
input = [0,0,0,0,0,0.0]

for i in 1:20
	println(@elapsed quadratize_costs(states, input))
end