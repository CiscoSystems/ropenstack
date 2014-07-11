require 'ropenstack/common/rest'

module Ropenstack
  ##
  # * Name: Database
  # * Description: Implementation of the Block Storage API Client in Ruby.
  # * Author: Sam 'Tehsmash' Betts, John Davidge
  # * Date: 30/06/2014
  ##
  class Database < OpenstackService
    # Pull in sub-modules.
    require 'ropenstack/database/v1'

    def initialize(location, token, type, accountid)
      super(location, token)
      @accountid = accountid
      case type
      when "database" then extend Version1
      else
        raise Ropenstack::RopenstackError, "Invalid type passed to Database"
      end
    end
  end
end
