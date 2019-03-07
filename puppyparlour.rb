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


services = Services.new()

services.user_data.get_all_data
services.which_service
services.add_extras
services.another_dog
services.create_invoice




