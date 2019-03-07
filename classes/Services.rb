# Creating the Services class in which the service and extras selection menus are defined as instance methods. It stores total cost for services and also the 
# total time required to perform services.
class Services
    # These variables all at some point require re-writing, and also require the ability to be read, so we have placed them in attr_accessor
    attr_accessor :total_cost, :user_data, :time_for_service, :reselect_rebook
    # These variables only need to be read by our program so we placed them in attr_reader
    attr_reader :service_selected, :dog

    def initialize()
        # We initialise the services class with the creation of a UserData object. This allows our class to access the data the user inputs within its
        # instance methods
        @user_data = UserData.new
        # The accumulator for total cost of the service selected and each of the extras selected
        @total_cost = 0
        # The flag which takes user input for selection of additional extras. This needed to be in the initialise, as we held the extras case statement
        # within it's own instance method, to help keep our code DRY. It was being called multiple times in the add_extras method, and was making
        # very repetitive code.
        @extra_no = 0
        # The accumulator which will calculate the pickup time, as determined by what services and extras are selected. Each service and extra has it's
        # own indepedent time to perform. They will add to this variable, which is initiated at the time the booking is being created.
        @time_for_service = Time.now
        # The time_limitation instance method is called within other methods, and so needs this to be accessible outside of itself.
        @reselect_rebook = ""
        @service_selected = 0
    end

    # Defining the method which will allow the user to select one of the four services, and add their cost, to @total_cost. 
    # Or the user has the option to select no service, and continue on to extras selection.
    def which_service
        # This puts block prompts the user to select the service that they would like, interpolating the cost based on the size of dog selected when
        # get_dog_size is called. It tells users how long each service will take, allowing them to determine whether business hours will permit the service
        # that they want, in that day.
        puts "Which service would you like?"
        puts "Select Service 1, 2, 3, 4, or 5:"
        # Making user aware of New Year Special offer, and also what our regular dogsitting price is
        puts "(New Year Special: If you select a service, puppysitting will only be $10, otherwise it will be $50)"
        puts "1. Wash and Dry ($#{@user_data.dog.wash_dry_cost} and will take 1 hour)"
        puts "2. Wash and Tidy ($#{@user_data.dog.wash_tidy_cost} and will take 1.5 hours)"
        puts "3. Full Groom ($#{@user_data.dog.full_groom_cost} and will take 3 hours)"
        puts "4. Style Cut ($#{@user_data.dog.style_cut_cost} and will take 4 hours)"
        puts "5. None, I only want extras"
        # This disclaimer was necessary as we had to take into consideration that the condition of the coat may influence the price
        # e.g. a full groom for a large malamute may cost more money, as they have an irregularly dense coat.
        puts "(DISCLAIMER: The condition of your dogs coat may alter the total cost for your service choice)"
        # Collecting the users service selection ensuring the input is an integer for data validation
        @service_selected = gets.chomp.to_i
        # Defining the method control flow based on user service selection
        case @service_selected
        # When the user selects the Wash and Dry service, this will call the wash_and_dry method
        when 1
            wash_and_dry
        # When the user selects the Wash and Tidy service, this will call the wash_and_tidy method
        when 2
            wash_and_tidy
        # When the user selects the Full Groom service, this will call the full_groom method
        when 3
            full_groom
        # When the user selects the Style Cut service, this will call the style_cut method
        when 4
            style_cut
        # If the user does not want a service, and only wants extras we want to alter the cost of puppysitting, to reflect our New Year Special offer
        # as described in the above puts block above
        when 5
            @user_data.dog.puppysitting_cost = 50
        end
        # Ensuring that the services selected will not take longer to perform, than there is time left within our business hours
        time_limitation
    end

    # Each of the following service methods, increment the total cost based on which option was selected by the user. The cost added to total cost
    # is depedent on what size the user said that their dog was, when asked for this input earlier.
    # The @time_for_service variable will also be incremented depending on which service was collected, and how long they are expected to take. This will
    # change the pickup time for the dog, or potentially limit the availability of that service for that day (see time_limitation method)

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

    # This is instance method is setting up the input block for users to select extra services
    def add_extras
        # Clearing the screen each time this method is called (as it is called regularly and multiple times in a row) to keep the terminal tidy
        puts `clear`
        puts "Would you like any other extras services added to your booking today? (y/n):"
        # We downcase the response just to ensure that if the user inputs YES, Y, NO, or N that the if block still runs
        response = gets.chomp.downcase
        if response == "yes" or response == "y"
            # We interpolate the costs from the dog object's superclass instance variables
            puts "Please select from the following extras:"
            puts "1. Gland Clean ($#{@user_data.dog.gland_clean_cost} and will take 15 minutes)"
            puts "2. De-matting/De-shedding ($#{@user_data.dog.dematting_shedding_cost} and will take 30 minutes)"
            puts "3. Paw Tidy ($#{@user_data.dog.paw_tidy_cost} and will take 15 minutes)"
            puts "4. Teeth Clean ($#{@user_data.dog.teeth_clean_cost} and will take 10 minutes)"
            puts "5. Specialty Shampoo ($#{@user_data.dog.specialty_shampoo_cost}, no extra time required)"
            puts "6. Puppy-sitting ($#{@user_data.dog.puppysitting_cost} - if you won't be available at collection time)"
            # Ensuring that the selection the user makes is an integer
            @extra_no = gets.chomp.to_i
            # Calling the extra_case instance method, and time limitation instance method. The extras_case method runs through all of the options
            # a user may have selected, and the time limitation method ensures there is enough time left in the day for the extras the user is selecting.
            extras_case
            time_limitation
        # The block will end if the user selects no, and the script will continue onto the next step.
        elsif response == "no" or response == "n"
        end
    end

    # An instance method used to help keep our script DRY. If a user selecteds an extra that they have already selected, it will let them know.
    def already_selected
        puts `clear`
        puts "You have already selected that extra!"
        puts
    end

    # This instance method contains our case statement for the different extra selection possibilities. This case statement appears in a few places, and
    # it was easier to keep our code DRY to put it in its own method.
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

    # The following set of methods are called when a user selects an extra. It ensures they have not selected it before, and adds the cost of that extra service
    # to the total cost. In addition it also adds to the time accumulator, @time_for_service, which ensures the total time for all service/extras selected
    # will not push the grooming outside of our business hours.

    # Defining the gland clean extra instance method
    def gland_clean
        # This if block ensure that the user has not selected this extra before. If they had this if block would have already executed, and set the flag
        # to false.
        if @user_data.dog.gland_clean_selected == false
            # Incrementing the total cost to include the cost of this extra. This cost value is called from the dog object's superclass instance variables.
            @total_cost += @user_data.dog.gland_clean_cost
            # Setting the selected flag to true, so that the user cannot select this extra again.
            @user_data.dog.gland_clean_selected = true
            # Incrementing the total time for service
            @time_for_service += 900
        # The else block should execute when the user has already selected this extra before, it will call already_selected which asks for the user
        # to try again, if they did still wish to add an additional extra.
        else
            already_selected
        end
        # Calling add_extras again. Without this, the user would only be able to select one extra. This will ask them if they would like another.
        add_extras
    end

    # See gland_clean method comments. This serves the same person, but for the dematting_shedding extra.
    def dematting_shedding
        if @user_data.dog.dematting_shedding_selected == false
            @total_cost += @user_data.dog.dematting_shedding_cost
            @user_data.dog.dematting_shedding_selected = true
            @time_for_service += 1800
        else
            already_selected
        end
        add_extras
    end

    # See gland_clean method comments. This serves the same person, but for the paw_tidy extra.
    def paw_tidy
        if @user_data.dog.paw_tidy_selected == false
            @total_cost += @user_data.dog.paw_tidy_cost
            @user_data.dog.paw_tidy_selected = true
            @time_for_service += 900
        else
            already_selected
        end
        add_extras
    end

    # See gland_clean method comments. This serves the same person, but for the teeth_clean extra.
    def teeth_clean
        if @user_data.dog.teeth_clean_selected == false
            @total_cost += @user_data.dog.teeth_clean_cost
            @user_data.dog.teeth_clean_selected = true
            @time_for_service += 600
        else
            already_selected
        end
        add_extras
    end

    # See gland_clean method comments. This serves the same person, but for the specialty_shampoo extra.
    # There is one notable difference here which is that this method does not increment the @time_for_service instance variable. We thought that in reality
    # this service would not take any additional time. 
    def specialty_shampoo
        if @user_data.dog.specialty_shampoo_selected == false
            @total_cost += @user_data.dog.specialty_shampoo_cost
            @user_data.dog.specialty_shampoo_selected = true
        else
            already_selected
        end
        add_extras
    end

    # See gland_clean method comments. This serves the same person, but for the puppysitting extra.
    # Again this does not increment @time_for_service as it will not take any time, it just allows users to pick their dog up within collection
    # hours, rather than at pickup time.
    def puppysitting
        if @user_data.dog.puppysitting_selected == false
            @total_cost += @user_data.dog.puppysitting_cost
            @user_data.dog.puppysitting_selected = true
        else
            already_selected
        end
        add_extras
    end

    # The another_dog instance method will ask users if they have another dog that they would like to book services for 
    def another_dog
        puts "Do you have another dog? (y/n):"
        # Requesting input from user regarding whether or not they have another dog
        other_dog = gets.chomp.downcase
        # The until into if loop forces one of four options ("y", "yes", "n", or "no"). Unless one of these is selected, they will remain in this loop
        # asking them for valid input
        until other_dog == "no" or other_dog == "n"
            # If the user selects yes, then they will be asked to input the dog data, and be asked for which services and extras that they would like for
            # their dog.
            if other_dog == "yes" or other_dog == "y"
                @user_data.get_dog_data
                which_service
                add_extras
                another_dog
            end
            puts "Please select yes (y) or no (n):"
            other_dog = gets.chomp.downcase
        end
    end

    # We created this instance method so we could ensure selection any combination of services and extras, would not go past 5:00PM, which is the latest
    # time that we perform these services
    def time_limitation
        # This line checks to see if @time_for_service is greater than 05:00PM on any given day
        if @time_for_service > Time.local((Time.now.year), (Time.now.month), (Time.now.day), 17, 0, 0)
            # @time_for_service is greater than 05:00PM the user is informed of this, and asked if they would like to rebook, or choose
            # a different service, which fits within our treatment schedule
            puts "This request does not fit into today's service schedule, choose a different service for today, or rebook for another day?:"
            puts "1. Reselect services"
            puts "2. Rebook"
            @reselect_rebook = gets.chomp
            # The until into if loop forces one of two options ("1", or "2"). Unless one of these is selected, they will remain in this loop
            # asking them for valid input
            until @reselect_rebook == "2"
                if @reselect_rebook == "1"
                    # If the user does want to select a different service, and fit in with our schedule, the @time_for_service is reset. This is to ensure
                    # the new selection fits within our schedule, otherwise it would add to their previous selections @time_for_service.
                    @time_for_service = Time.now
                    # The user is prompted to select a service with the which_service instance method
                    which_service
                    break
                end
                puts "Please select 1 or 2."
                @reselect_rebook = gets.chomp
            end
            # If the user does not want to select select another service, they are prompted to call us so we can schedule them in at the next
            # available appointment. If the until loop above is broken, then either @reselect_rebook != to "1" and this if loop will not run.
            # If did break because the user selected "2", this if loop will run. Otherwise the method will end.
            if @reselect_rebook == "2"
                puts "Please call us on 040404040 to schedule at our next available appointment"
                exit
            end
        end 
    end

    # Defining the method that allows us to create an invoice
    def invoice_creation
        # If the user has not selected puppysitting, this will print the collection time as the @time_for_service instance variable in a readable string
        # format
        if @user_data.dog.puppysitting_selected == false
            puts "#{@user_data.dog_name} will be ready at #{@time_for_service.strftime("at %I:%M %p")}"
            puts "If #{@user_data.dog_name} is ready before then we will call you on #{@user_data.owner_contact} "
            puts "Here is your invoice: "
            invoice = Terminal::Table.new
            invoice.title = "Puppy Parlour Invoice"
            invoice.add_separator
            invoice << ["Owner Name", @user_data.owner_name]
            invoice << ["Pet Name", @user_data.dog_name]
            invoice.add_separator
            invoice << ["Service", "Cost ($)"]
            invoice.add_separator
            case @service_selected
            when 1
                invoice << ["Wash and Dry", @user_data.dog.wash_dry_cost]
            when 2
                invoice << ["Wash and Tidy", @user_data.dog.wash_tidy_cost] 
            when 3
                invoice << ["Full Groom", @user_data.dog.full_groom_cost]
            when 4
                invoice << ["Style Cut", @user_data.dog.style_cut_cost]
            end
            if @user_data.dog.gland_clean_selected == true
                invoice << ["Gland Clean", @user_data.dog.gland_clean_cost]
            end
            if @user_data.dog.dematting_shedding_selected == true
                invoice << ["Dematting/Deshedding", @user_data.dog.dematting_shedding_cost]
            end
            if @user_data.dog.paw_tidy_selected == true
                invoice << ["Paw Tidy", @user_data.dog.paw_tidy_cost]
            end
            if @user_data.dog.teeth_clean_selected == true
                invoice << ["Teeth Clean", @user_data.dog.teeth_clean_cost]
            end
            if @user_data.dog.specialty_shampoo_selected == true
                invoice << ["Specialty Shampoo", @user_data.dog.specialty_shampoo_cost]
            end
            if @user_data.dog.puppysitting_selected == true
                invoice << ["Puppysitting", @user_data.dog.puppysitting_cost]
            end
            invoice.add_separator
            invoice << ["Total", @total_cost]
            print invoice
        # If the user has selected puppysitting, this will create an invoice and also inform the user of collection hours for their dog
        elsif @user_data.dog.puppysitting_selected == true
            puts "#{@user_data.dog_name} will be ready for collection between 5PM-6PM today. See you then!"
            puts "Here is your invoice: "
            invoice = Terminal::Table.new
            invoice.title = "Puppy Parlour Invoice"
            invoice.add_separator
            invoice << ["Owner Name", @user_data.owner_name]
            invoice << ["Pet Name", @user_data.dog_name]
            invoice.add_separator
            invoice << ["Service", "Cost ($)"]
            invoice.add_separator
            case service_selected
            when 1
                invoice << ["Wash and Dry", @user_data.dog.wash_dry_cost]
            when 2
                invoice << ["Wash and Tidy", @user_data.dog.wash_tidy_cost] 
            when 3
                invoice << ["Full Groom", @user_data.dog.full_groom_cost]
            when 4
                invoice << ["Style Cut", @user_data.dog.style_cut_cost]
            end
            if @user_data.dog.gland_clean_selected == true
                invoice << ["Gland Clean", @user_data.dog.gland_clean_cost]
            end
            if @user_data.dog.dematting_shedding_selected == true
                invoice << ["Dematting/Deshedding", @user_data.dog.dematting_shedding_cost]
            end
            if @user_data.dog.paw_tidy_selected == true
                invoice << ["Paw Tidy", @user_data.dog.paw_tidy_cost]
            end
            if @user_data.dog.teeth_clean_selected == true
                invoice << ["Teeth Clean", @user_data.dog.teeth_clean_cost]
            end
            if @user_data.dog.specialty_shampoo_selected == true
                invoice << ["Specialty Shampoo", @user_data.dog.specialty_shampoo_cost]
            end
            if @user_data.dog.puppysitting_selected == true
                invoice << ["Puppysitting", @user_data.dog.puppysitting_cost]
            end
            invoice.add_separator
            invoice << ["Total", @total_cost]
            print invoice
        end
    end
end