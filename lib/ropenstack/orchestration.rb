require 'ropenstack/common/rest'

module Ropenstack
  ##
	# * Name: Orchestration
	# * Description: Implementation of the Orchestration API Client in Ruby 
	# * Author: Sam 'Tehsmash' Betts, John Davidge
	# * Date: 30/06/2014
  ##
  class Orchestration < OpenstackService
    # Pull in sub-modules 
    require 'ropenstack/orchestration/v1'

    def intialize(location, token, type)
      super(location, token)
      case type
      when "orchestration" then extend Version1
      else
        raise Ropenstack::RopenstackError, "Invalid type passed to Orchestration"
      end
    end
  end
end
