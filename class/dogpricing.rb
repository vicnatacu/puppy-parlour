# Creating superclass dog to hold extra service costs, that are the same across all dog sizes.
class DogPricing
    attr_accessor :gland_clean_selected, :dematting_shedding_selected, :paw_tidy_selected, :teeth_clean_selected, :specialty_shampoo_selected, :puppysitting_selected,  :puppysitting_cost
    attr_reader :gland_clean_cost, :dematting_shedding_cost, :paw_tidy_cost, :teeth_clean_cost, :specialty_shampoo_cost

    def initialize
        @gland_clean_cost = 30
        @gland_clean_selected = false
        @dematting_shedding_cost = 15
        @dematting_shedding_selected = false
        @paw_tidy_cost = 5
        @paw_tidy_selected = false
        @teeth_clean_cost = 10
        @teeth_clean_selected = false
        @specialty_shampoo_cost = 15
        @specialty_shampoo_selected = false
        @puppysitting_cost = 10
        @puppysitting_selected = false 
    end
end