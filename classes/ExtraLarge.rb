# Requiring the DogPricing superclass for this subclass. Without this we would not be able to instantiate subclass objects of superclass DogPricing.
require_relative './DogPricing'

# The subclass ExtraLarge under superclass DogPricing holds all of the costs for services for extra large sized dogs
class ExtraLarge < DogPricing
    # We only want to be able to read these variables. If the costs are to be changed in the future, they should be changed within the specific subclasses variable.
    attr_reader :wash_dry_cost, :wash_tidy_cost, :full_groom_cost, :style_cut_cost
    
    # Initialising service costs for extra large sized dogs. We call super so that the subclass has access to the variables of its superclass DogPricing.
    def initialize
        super
        @wash_dry_cost = 90
        @wash_tidy_cost = 100
        @full_groom_cost = 135
        @style_cut_cost = 180
    end
end
