require 'ropenstack/common/rest'

module Ropenstack
  ##
  # * Name: Image
	# * Description: Implementation of the Glance API Client in Ruby
	# * Author: Sam 'Tehsmash' Betts, John Davidge
	# * Date: 30/06/2014
  ##
  class Image < OpenstackService
    # Pull in sub-modules
    require 'ropenstack/image/v1'
    require 'ropenstack/image/v2'

    def initialize(location, token, type)
      super(location, token)
      case type
      when "image" then extend Version1
      when "imagev2" then extend Version2
      else
        raise Ropenstack::RopenstackError, "Invalid type passed to Image"
      end
     end
  end
end
