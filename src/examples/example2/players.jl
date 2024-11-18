include("../../structs/player.jl")

const car1 = let
	costinfo = CostInfoT4(15,pi/2, 1, [[-1,-1000.0],[-1,1000.0]], 2.5)
	state_weight = StateCostWeightT4(10, 10050, 100, 100, 100)
	input_weight = InputCostWeightT1(10, 10)
	stindex = StateIndexT1([1,2],3,4,[[1,2],[5,6],[9,10]])
	inindex = InputIndexT1(1,2,[[1,2],[3,4],[5,6]])

	PlayerT4(stindex,inindex,costinfo,state_weight,input_weight)
end

const car2 = let
	costinfo = CostInfoT4(10,pi/2, 1, [[-1,-1000.0],[-1,1000.0]], 2.5)
	state_weight = StateCostWeightT4(1, 150, 100, 100, 100)
	input_weight = InputCostWeightT1(10,10)
	stindex = StateIndexT1([5,6],7,8,[[1,2],[5,6],[9,10]])
	inindex = InputIndexT1(3,4,[[1,2],[3,4],[5,6]])

	PlayerT4(stindex,inindex,costinfo,state_weight,input_weight)
end

const car3 = let
	costinfo = CostInfoT4(10, pi/2, 1, [[2.5,-1000.0],[2.5,1000.0]], 2.5)
	state_weight = StateCostWeightT4(1,150, 100, 100, 100)
	input_weight = InputCostWeightT1(10,10)
	stindex = StateIndexT1([9,10],11,12,[[1,2],[5,6],[9,10]])
	inindex = InputIndexT1(5,6,[[1,2],[3,4],[5,6]])

	PlayerT4(stindex,inindex,costinfo,state_weight,input_weight)
end

const players = [car1,car2,car3]
