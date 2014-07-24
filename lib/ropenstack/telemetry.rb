require 'ropenstack/common/rest'

module Ropenstack
  ##
	# * Name: Telemetry
	# * Description: Implementation of the Telemetry API Client in Ruby 
	# * Author: Sam 'Tehsmash' Betts, John Davidge
	# * Date: 30/06/2014
  ##
  class Telemetry < OpenstackService
    # Pull in submodules.
    require 'ropenstack/telemetry/v2'

    def intialize(location, token, type)
      super(location, token)
      case type
      when "telemetry" then extend Version2
      else
        raise Ropenstack::RopenstackError, "Invalid type passed to Telemetry"
      end
    end
  end
end
