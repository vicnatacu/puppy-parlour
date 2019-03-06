# Creating a class, that will store the data that we collect from the user
class UserData
    attr_accessor :owner_name, :owner_contact, :location, :dog_name, :dog_breed, :dog_size, :dog

    # Initialising all of the variables we need to collect and have access to
    def initialize()
        @owner_name = ""
        @owner_contact = ""
        @dog_name = ""
        @dog_breed = ""
        @dog_size = ""
        @location = ""
        @dog = ""
    end 

    # Defining the get_location method which will set the location at which the booking will be made
    def get_location
        puts "We have franchises at: Bulimba, South Brisbane City, and Paddington."
        puts "Which franchise would you like to make a booking at?:"
        @location = gets.chomp
    end

    # Collecting the owner's name from user and and assigning to @owner_name
    def get_owner_name
        puts "What is your name?:"
        @owner_name = gets.chomp.to_s
    end

    # Collecting owner's contact number from user and assigning to @owner_contact
    def get_owner_contact
        puts "What is your preferred contact number?:"
        @owner_contact = gets.chomp
    end

    # Collecting dog's name from user and assigning to @dog_name
    def get_dog_name
        puts "What is your dog's name?:"
        @dog_name = gets.chomp
    end

    # Collecting dog's breed from user and assigning to @dog_breed
    def get_dog_breed
        puts "What breed is your dog?:"
        @dog_breed = gets.chomp
    end

    # Asking the user for the size of their dog, and enforcing certain string input (S, M, L, XL)
    def get_dog_size
        puts "Roughly, what size would you say that your dog is? (S, M, L, XL):"
        @dog_size = gets.chomp
        dog_size_case
            until @dog_size == "S" or @dog_size == "M" or @dog_size == "L" or @dog_size == "XL"
                puts "Enter a valid dog size:"
                @dog_size = gets.chomp
                dog_size_case
            end
    end

    # dog_size_case creates an object of one of the four Dog subclasses; the Small subclass, Medium subclass, Large subclass or ExtraLarge subclass.
    # Object creation is dependent on user input from the get_dog_size instance method.
    def dog_size_case
        case 
        when @dog_size == "S"
            @dog = Small.new()
        when @dog_size == "M"
            @dog = Medium.new()
        when @dog_size == "L"
            @dog = Large.new()
        when @dog_size == "XL"
            @dog = ExtraLarge.new()
        end
    end

    def get_all_data
        get_location
        get_owner_name
        get_owner_contact
        get_dog_data
    end

    def get_dog_data
        get_dog_name
        get_dog_breed
        get_dog_size
    end
end

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

class Services
    attr_accessor :total_cost, :user_data, :time_for_service, :reselect_rebook

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
        @service_selected = gets.chomp.to_i
        case
        when @service_selected == 1
            wash_and_dry
        when @service_selected == 2
            wash_and_tidy
        when @service_selected == 3
            full_groom
        when @service_selected == 4
            style_cut
        when @service_selected == 5
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
        case
        when @extra_no == 1
            gland_clean
        when @extra_no == 2
            dematting_shedding
        when @extra_no == 3
            paw_tidy
        when @extra_no == 4
            teeth_clean
        when @extra_no == 5
            specialty_shampoo
        when @extra_no == 6
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

services = Services.new()

services.user_data.get_all_data
services.which_service
services.add_extras
# services.add_extras
# services.another_dog
# puts services.total_cost