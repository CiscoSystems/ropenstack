require 'ropenstack/common/rest'
require 'ropenstack/common/openstackservice'

module Ropenstack
  ##
  # * Name: BlockStorage
  # * Description: Implementation of the Block Storage API Client in Ruby.
  # * Author: Sam 'Tehsmash' Betts
  # * Date: 01/15/2013
  ##
  class BlockStorage < OpenstackService
    require 'ropenstack/blockStorage/v1'
    require 'ropenstack/blockStorage/v2'

    def initialize(location, token, type)
      super(location, token)
      case type
      when "volume" then extend Version1
      when "volumev2" then extend Version2
      else 
        raise Ropenstack::RopenstackError, "Invalid Type Passed to BlockStorage"
      end
    end
  end
end
