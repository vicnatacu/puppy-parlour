class Services
    attr_accessor :total_cost, :user_data, :time_for_service, :reselect_rebook
    attr_reader :service_selected, :dog

    def initialize()
        @user_data = UserData.new
        @total_cost = 0
        @service_selected = 0
        @response = ""
        @extra_no = 0
        @time_for_service = Time.now
        @reselect_rebook = ""
    end

    def which_service
        puts "Which service would you like?"
        puts "Select Service 1, 2, 3, 4, or 5:"
        puts "(New Year Special: If you select a service, puppysitting will only be $10, otherwise it will be $50)"
        puts "1. Wash and Dry ($#{@user_data.dog.wash_dry_cost} and will take 1 hour)"
        puts "2. Wash and Tidy ($#{@user_data.dog.wash_tidy_cost} and will take 1.5 hours)"
        puts "3. Full Groom ($#{@user_data.dog.full_groom_cost} and will take 3 hours)"
        puts "4. Style Cut ($#{@user_data.dog.style_cut_cost} and will take 4 hours)"
        puts "5. None, I only want extras"
        puts "(DISCLAIMER: The condition of your dogs coat may alter the total cost for your service choice)"
        @service_selected = gets.chomp.to_i
        case @service_selected
        when 1
            wash_and_dry
        when 2
            wash_and_tidy
        when 3
            full_groom
        when 4
            style_cut
        when 5
            @user_data.dog.puppysitting_cost = 50
        end
        time_limitation
        puts "Your total cost is $#{@total_cost}"
    end

    def wash_and_dry
        @total_cost += @user_data.dog.wash_dry_cost
        @time_for_service += 3600
    end

    def wash_and_tidy
        @total_cost += @user_data.dog.wash_tidy_cost
        @time_for_service += 5400
    end

    def full_groom
        @total_cost += @user_data.dog.full_groom_cost
        @time_for_service += 10800
    end

    def style_cut
        @total_cost += @user_data.dog.style_cut_cost
        @time_for_service += 14400
    end

    def add_extras
        puts "Would you like any extras added to your service today? (y/n):"
        @response = gets.chomp.downcase
        if @response == "yes" or @response == "y"
            puts "Please select from the following extras:"
            puts "1. Gland Clean ($#{@user_data.dog.gland_clean_cost} and will take 15 minutes)"
            puts "2. De-matting/De-shedding ($#{@user_data.dog.dematting_shedding_cost} and will take 30 minutes)"
            puts "3. Paw Tidy ($#{@user_data.dog.paw_tidy_cost} and will take 15 minutes)"
            puts "4. Teeth Clean ($#{@user_data.dog.teeth_clean_cost} and will take 10 minutes)"
            puts "5. Specialty Shampoo ($#{@user_data.dog.specialty_shampoo_cost}, no extra time required)"
            puts "6. Puppy-sitting ($#{@user_data.dog.puppysitting_cost} - if you won't be available at collection time)"
            @extra_no = gets.chomp.to_i
            extras_case
            time_limitation
        elsif @response == "no" or @response == "n"
        end
    end

    def already_selected
        puts "You have already selected that extra:"
        puts "Would you like another extra? (y/n):"
            @extra_no = gets.chomp.to_i
    end

    def extras_case
        case @extra_no
        when 1
            gland_clean
        when 2
            dematting_shedding
        when 3
            paw_tidy
        when 4
            teeth_clean
        when 5
            specialty_shampoo
        when 6
            puppysitting
        end
    end

    def gland_clean
        if @user_data.dog.gland_clean_selected == false
        @total_cost += @user_data.dog.gland_clean_cost
        @user_data.dog.gland_clean_selected = true
        @time_for_service += 900
        else
            already_selected
            extras_case
        end
        add_extras
    end

    def dematting_shedding
        if @user_data.dog.dematting_shedding_selected == false
            @total_cost += @user_data.dog.dematting_shedding_cost
            @user_data.dog.dematting_shedding_selected = true
            @time_for_service += 1800
        else
            already_selected
            extras_case
        end
        add_extras
    end

    def paw_tidy
        if @user_data.dog.paw_tidy_selected == false
            @total_cost += @user_data.dog.paw_tidy_cost
            @user_data.dog.paw_tidy_selected = true
            @time_for_service += 900
        else
            already_selected
            extras_case
        end
        add_extras
    end

    def teeth_clean
        if @user_data.dog.teeth_clean_selected == false
            @total_cost += @user_data.dog.teeth_clean_cost
            @user_data.dog.teeth_clean_selected = true
            @time_for_service += 600
        else
            already_selected
            extras_case
        end
        add_extras
    end

    # Won't need addition to time_for_service counter as this service realistically would not add to total time for service
    def specialty_shampoo
        if @user_data.dog.specialty_shampoo_selected == false
            @total_cost += @user_data.dog.specialty_shampoo_cost
            @user_data.dog.specialty_shampoo_selected = true
        else
            already_selected
            extras_case
        end
        add_extras
    end

    def puppysitting
        if @user_data.dog.puppysitting_selected == false
            @total_cost += @user_data.dog.puppysitting_cost
            @user_data.dog.puppysitting_selected = true
        else
            already_selected
            extras_case
        end
        add_extras
    end

    def another_dog
        puts "Do you have another dog? (y/n):"
        other_dog = gets.chomp
        if other_dog == "yes" or other_dog == "y"
            @user_data.get_dog_data
            which_service
            add_extras
            another_dog
        elsif other_dog == "no" or other_dog == "n"
        end   
    end

    # def collection_time
    #     return "Your puppy will be ready for collection #{@services.time_for_service.strftime("%I:%M %p")}"
    # end

    def time_limitation
        if @time_for_service > Time.local((Time.now.year), (Time.now.month), (Time.now.day), 17, 0, 0)
            puts "This request does not fit into today's service schedule, choose a different service for today, or rebook for another day?:"
            puts "1. Reselect services"
            puts "2. Rebook"
            @reselect_rebook = gets.chomp
            if @reselect_rebook == "1"
                @time_for_service = Time.now
                which_service
            elsif @reselect_rebook == "2"
                puts "Please call us on 040404040 to schedule at our next available appointment"
                exit
            else
                puts "Please select 1 or 2."
                time_limitation
            end
        end 
    end
end