include("../../structs/player.jl")

const car1 = let
	stindex = StateIndexT1([1,2],3,4,[[1,2],[5,6],[9,10]])
	inindex = InputIndexT1([[1,2],[3,4],[5,6]],1,2)
	costinfo = CostInfoT1([6,35],10,0,8,10,[[6.0,-100.0],[6.0,100.0]],1)
	state_weight = StateCostWeightT1(4,50,50,100,100,0,100)
	input_weight = InputCostWeightT1(25,1)

	PlayerT1(stindex,inindex,costinfo,state_weight,input_weight)
end

const car2 = let
	stindex = StateIndexT1([5,6],7,8,[[1,2],[5,6],[9,10]])
	inindex = InputIndexT1([[1,2],[3,4],[5,6]],3,4)
	costinfo = CostInfoT1([12,12],10,0,5,2,[[2.0,100.0],[2.0,18.0],[2.5,15.0],[3.0,14.0],[5.0,12.5],[8.0,12.0],[100.0,12.0]],1)
	state_weight = StateCostWeightT1(3,50,50,100,100,0,100)
	input_weight = InputCostWeightT1(25,1)

	PlayerT1(stindex,inindex,costinfo,state_weight,input_weight)
end

const bicycle = let
	stindex = StateIndexT1([9,10],11,12,[[1,2],[5,6],[9,10]])
	inindex = InputIndexT2([[1,2],[3,4],[5,6]],5,6)
	costinfo = CostInfoT2([15,21],8,0,4,1)
	state_weight = StateCostWeightT2(1,100,100,0,100)
	input_weight = InputCostWeightT2(1,1)

	PlayerT2(stindex,inindex,costinfo,state_weight,input_weight)
end

const players = [car1,car2,bicycle]
