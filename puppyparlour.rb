# Requiring the terminal-table gem as it is used to create a services invoice
require 'terminal-table'
# Requiring the class folder files for each individual class and subclass required within our app script
require_relative './classes/UserData'
require_relative './classes/Small'
require_relative './classes/Medium'
require_relative './classes/Large'
require_relative './classes/ExtraLarge'
require_relative './classes/Services'
require_relative './classes/DogPricing'

# Creating an object of the Services class to call methods on and also to allow us to print it's instance variables
services = Services.new()

# Introduction message with some puts for formatting
puts
puts "Welcome to the Puppy Parlour!"
puts "-----------------------------"
puts
# Prompting the user to input their data
services.user_data.get_all_data
# Clearing the screen for readability
puts `clear`
# Asking the user for service selection
services.which_service
# Clearing the screen for readability
puts `clear`
# Prompting the user select their extras
services.add_extras
# Clearing the screen for readability
puts `clear`
# Asking the user if they have another dog they would like to make a booking for
services.another_dog
# Clearing the screen for readability
puts `clear`
# Printing the invoice for the user, and also informing the user of either the pickup time for their pooch, or the collection hours for puppysitting, if selected.
services.invoice_creation
puts
puts
