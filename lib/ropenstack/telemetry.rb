require 'ropenstack/common/rest'
require 'ropenstack/telemetry/v2'

module Ropenstack
  ##
	# * Name: Telemetry
	# * Description: Implementation of the Telemetry API Client in Ruby 
	# * Author: Sam 'Tehsmash' Betts, John Davidge
	# * Date: 30/06/2014
  ##
  class Telemetry < OpenstackService
    def intialize(location, token, type)
      super(location, token)
      case type
      when "telemetry" then extend TelemetryVersion2
      else
        raise Ropenstack::RopenstackError, "Invalid type passed to Telemetry"
      end
    end
  end
end
