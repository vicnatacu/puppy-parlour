require './dogpricing'

class ExtraLarge < DogPricing
    attr_accessor :wash_dry_cost, :wash_tidy_cost, :full_groom_cost, :style_cut_cost

    def initialize
        super
        @wash_dry_cost = 90
        @wash_tidy_cost = 100
        @full_groom_cost = 135
        @style_cut_cost = 180
    end
end
