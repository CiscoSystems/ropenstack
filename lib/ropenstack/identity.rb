require 'ropenstack/common/rest'
require 'ropenstack/identity/v2'
require 'ropenstack/identity/v3'

module Ropenstack
  ##
  # * Name: Identity	
  # * Description: An implementation of the Identity API Client in Ruby
  # * Author: Sam 'Tehsmash' Betts, John Davidge
  # * Date: 30/16/2014
  ##
  class Identity < OpenstackService
    def initialize(location, port, token, type)
      super(location + ":" + port.to_s, token)
      case type
      when "identityv2" then extend IdentityVersion2
      when "identityv3" then extend IdentityVersion3
      else
        raise Ropenstack::RopenstackError, "Invalid Type Passed to Identity"
      end
      unless token.nil?
        @data = { "access" => { "token" => { "id" => token } } } 
      end
    end
  end
end
