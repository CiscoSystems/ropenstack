require 'ropenstack/common/rest'

module Ropenstack
  ##
  # * Name: Identity	
  # * Description: An implementation of the Identity API Client in Ruby
  # * Author: Sam 'Tehsmash' Betts, John Davidge
  # * Date: 30/16/2014
  ##
  class Identity < OpenstackService
    # Pull in sub-modules.
    require 'ropenstack/identity/v2'
    require 'ropenstack/identity/v3'

    def initialize(location, port, token, type)
      super(location + ":" + port.to_s, token)
      case type
      when "identityv2" then extend Version2
      when "identityv3" then extend Version3
      else
        raise Ropenstack::RopenstackError, "Invalid Type Passed to Identity"
      end
      unless token.nil?
        @data = { "access" => { "token" => { "id" => token } } } 
      end
    end
  end
end
