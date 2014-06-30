require 'ropenstack/common/rest'
require 'ropenstack/identity/v1'
require 'ropenstack/identity/v2'

module Ropenstack
  ##
  # * Name: Identity	
  # * Description: An implementation of the Identity API Client in Ruby
  # * Author: Sam 'Tehsmash' Betts, John Davidge
  # * Date: 30/16/2014
  ##
  class Identity < OpenstackService
    def initialize(location, token, type)
			super(location, token)
			case type
			when "identity" then extend IdentityVersion1
			when "identityv2" then extend IdentityVersion2
			else
				raise Ropenstack::RopenstackError, "Invalid Type Passed to Identity"
			end
		end
	end
end
