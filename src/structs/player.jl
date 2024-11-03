include("substructs/index.jl")
include("substructs/cost_info.jl")
include("substructs/weight.jl")
include("../types/basic.jl")

struct PlayerT1 <: PlayerType
	state_index::StateIndexT1
	input_index::InputIndexT1
	cost_info::CostInfoT1
	state_cost_weight::StateCostWeightT1
	input_cost_weight::InputCostWeightT1
end

struct PlayerT2 <: PlayerType
	state_index::StateIndexT1
	input_index::InputIndexT2
	cost_info::CostInfoT2
	state_cost_weight::StateCostWeightT2
	input_cost_weight::InputCostWeightT2
end
