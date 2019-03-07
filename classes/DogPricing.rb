# Creating a superclass DogPricing which holds extra service costs, that are the same price across all dog sizes
# It also holds the flags _selected which help the extra's instance methods to recognise whether or not they have been selected already.
# We do not want users to be able to select an extra more than once.
class DogPricing
    # Each of the attr_accessor variables do need to be both readable and writable. The notable inclusion here is puppysitting_cost. We did want to be able
    # to edit this cost depending on whether or not a service was selected.
    attr_accessor :gland_clean_selected, :dematting_shedding_selected, :paw_tidy_selected, :teeth_clean_selected, :specialty_shampoo_selected, :puppysitting_selected,  :puppysitting_cost
    # The variables which define the extra service costs only need to be read. They should not be writable so we decided to use attr_reader for these.
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