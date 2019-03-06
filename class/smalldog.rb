require './dogpricing'

class Small < DogPricing
    attr_accessor :wash_dry_cost, :wash_tidy_cost, :full_groom_cost, :style_cut_cost

    def initialize
        super
        @wash_dry_cost = 45
        @wash_tidy_cost = 55
        @full_groom_cost = 75
        @style_cut_cost = 85
    end
end