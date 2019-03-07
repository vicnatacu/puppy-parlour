# Requiring the DogPricing superclass for this subclass. Without this we would not be able to instantiate subclass objects of superclass DogPricing.
require_relative './DogPricing'

# The subclass Medium under superclass DogPricing holds all of the costs for services for medium sized dogs
class Medium < DogPricing
    # We only want to be able to read these variables. If the costs are to be changed in the future, they should be changed within the specific subclasses variable.
    attr_reader :wash_dry_cost, :wash_tidy_cost, :full_groom_cost, :style_cut_cost

    # Initialising service costs for medium sized dogs. We call super so that the subclass has access to the variables of its superclass DogPricing.
    def initialize
        super
        @wash_dry_cost = 55
        @wash_tidy_cost = 65
        @full_groom_cost = 85
        @style_cut_cost = 105
    end
end