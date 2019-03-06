require './dogpricing'

class Large < DogPricing
    attr_accessor :wash_dry_cost, :wash_tidy_cost, :full_groom_cost, :style_cut_cost

    def initialize
        super
        @wash_dry_cost = 75
        @wash_tidy_cost = 85
        @full_groom_cost = 110
        @style_cut_cost = 140
    end
end