include("../../structs/player.jl")

const position_indices = [[1,2],[5,6],[9,10]]
const all_inputs_indices = [[1,2],[3,4],[5,6]]

const car1 = let
	costinfo = CostInfoT1([6,35],0,10,8,2,[[6.0,-100.0],[6.0,100.0]],1)
	state_weight = StateCostWeightT1(4,50,50,100,100,0,100)
	input_weight = InputCostWeightT1(25,1)

	stindex = StateIndexT1([1,2],3,4,position_indices)
	inindex = InputIndexT1(1,2,all_inputs_indices)

	PlayerT1(stindex,inindex,costinfo,state_weight,input_weight)
end

const car2 = let
	costinfo = CostInfoT1([12,12],0,10,5,2,[[2.0,100.0],[2.0,18.0],[2.5,15.0],[3.0,14.0],[5.0,12.5],[8.0,12.0],[100.0,12.0]],1)
	state_weight = StateCostWeightT1(4,50,50,100,100,0,100)
	input_weight = InputCostWeightT1(25,1)

	stindex = StateIndexT1([5,6],7,8,position_indices)
	inindex = InputIndexT1(3,4,all_inputs_indices)
	
	PlayerT1(stindex,inindex,costinfo,state_weight,input_weight)
end

const bicycle = let
	costinfo = CostInfoT2([15,21],0,7,4,1)
	state_weight = StateCostWeightT2(1,100,100,0,100)
	input_weight = InputCostWeightT2(1,1)

	stindex = StateIndexT1([9,10],11,12,position_indices)
	inindex = InputIndexT2(5,6,all_inputs_indices)

	PlayerT2(stindex,inindex,costinfo,state_weight,input_weight)
end

const players = [car1,car2,bicycle]