require 'ropenstack/common/rest'
require 'uri'

module Ropenstack
=begin
	* Name: Telemetry
	* Description: Implementation of the Telemetry API Client in Ruby 
	* Author: Sam 'Tehsmash' Betts
	* Date: 01/15/2013
=end
  class Telemetry < OpenstackService
    def alarms(id = nil)
    end

    def alarm_create
    end

    def alarm_update
    end

    def alarm_delete(id)
    end

    def alarm_state(id)
    end

    def alarm_history(id)
    end

    def meters(name = nil)
    end

    def samples 
    end

    def meter_statistics(meter)
    end

    def resources(id = nil)
    end
  end
end
