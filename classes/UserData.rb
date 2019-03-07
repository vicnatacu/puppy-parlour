# Creating a class UserData, that will store the data that we collect from the user
class UserData
    attr_accessor :owner_name, :owner_contact, :location, :dog_name, :dog_breed, :dog_size, :dog

    # Initialising all of the variables we need to collect and have access to (with attr_accessor: above)
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
        until @location == "Bulimba" or @location == "South Brisbane City" or @location == "Paddington"
            puts "Please select a valid franchise location:"
            @location = gets.chomp
        end
    end

    # Collecting the owner's name from user and and assigning to @owner_name
    def get_owner_name
        puts "What is your name?:"
        @owner_name = gets.chomp
    end

    # Collecting owner's contact number from user and assigning to @owner_contact
    # We used kept the 
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
    # We call dog_size_case to keep code dry
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
        case @dog_size
        when "S"
            @dog = Small.new()
        when "M"
            @dog = Medium.new()
        when "L"
            @dog = Large.new()
        when "XL"
            @dog = ExtraLarge.new()
        end
    end

    # An instance method to help create DRY code. Each method called within get_all_data collects certain user input as defined by their individual method
    def get_all_data
        get_location
        puts
        get_owner_name
        puts
        get_owner_contact
        puts `clear`
        get_dog_data
    end

    # A slightly more specific instance method to create DRY code. Primarily used to collect only dog data, when the another_dog instance method is called
    # within the Services class.
    def get_dog_data
        puts
        get_dog_name
        puts
        get_dog_breed
        puts
        get_dog_size
        puts
    end
end