require './dogpricing'

class Medium < DogPricing
    attr_accessor :wash_dry_cost, :wash_tidy_cost, :full_groom_cost, :style_cut_cost

    def initialize
        super
        @wash_dry_cost = 55
        @wash_tidy_cost = 65
        @full_groom_cost = 85
        @style_cut_cost = 105
    end
end