include("../../structs/player.jl")

const position_indices = [[1,2],[5,6],[9,10]]
const all_inputs_indices = [[1,2],[3,4],[5,6]]

const car1 = let
    costinfo = CostInfoT1([-2.0,50.0],0,15,8,6,[[-2.0,-1000.0],[-2.0,1000.0]],2.5)
    state_weight = StateCostWeightT1(1,25,3,10,10,100,10)
    input_weight = InputCostWeightT1(10,10)

    stindex = StateIndexT1([1,2],3,4,position_indices)
    inindex = InputIndexT1(1,2,all_inputs_indices)

    PlayerT1(stindex,inindex,costinfo,state_weight,input_weight)
end

const car2 = let
    costinfo = CostInfoT1([12,12],0,12,5,6,
                          [[-10, 1000.0],[-10,18],[-10 + 0.5, 15],[-10 + 1.0,14],[-10 + 3, 12.5],[-10 + 6, 12], [1000,12]],2.5)
    state_weight = StateCostWeightT1(1,25,3,10,10,100,10)
    input_weight = InputCostWeightT1(100,10)

    stindex = StateIndexT1([5,6],7,8,position_indices)
    inindex = InputIndexT1(3,4,all_inputs_indices)
    
    PlayerT1(stindex,inindex,costinfo,state_weight,input_weight)
end

const car3 = let
    costinfo = CostInfoT1([15,16],0,5,1.5,6,[[-1000,16],[1000,16]],2.5)
    state_weight = StateCostWeightT1(2,50,3,10,10,100,10)
    input_weight = InputCostWeightT1(100,10)

    stindex = StateIndexT1([9,10],11,12,position_indices)
    inindex = InputIndexT1(5,6,all_inputs_indices)
    
    PlayerT1(stindex,inindex,costinfo,state_weight,input_weight)
end



const players = [car1,car2,car3]