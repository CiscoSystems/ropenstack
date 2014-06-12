require 'ropenstack/common/rest'

module Ropenstack
  ##
  # * Name: Database
  # * Description: Implementation of the Block Storage API Client in Ruby.
  # * Author: Sam 'Tehsmash' Betts
  # * Date: 01/15/2013
  ##
  class Database < OpenstackService
    def initialize(location, token, accountid)
      super(location, token)
      @accountid = accountid
    end

    ## Database Instances
    def instances(id)
      if id.nil? 
        get_request(address("/instances"), @token)
      else
        get_request(address("/instances/" + id), @token)
      end
    end

    def instance_create(databases, flavorRef, name, users, volumes)
      ## TODO Construct data
      data = {}

      post_request(address("/instances"), data, @token)
    end

    def instance_delete(id)
      delete_request(address("/instances/" + id), @token)
    end

    def instance_root(id)
      get_request(address("/instances/" + id + "/root"), @token)
    end

    def instance_root_enable(id)
      ## Empty data field
      post_request(address("/instances/" + id + "/root"), {}, @token)
    end

    ## Database Instance Actions
    def instance_action(id, action, param)
      ## IF ACTION RESTART
      ## ELSE IF ACTION RESIZE
      #### IF PARAM IS INT
      #### ELSE IF PARAM IS STRING
      #### END 
      ## END
    end

    ## Databases
    def databases()
    end

    def database_create()
    end

    def database_delete()
    end

    ## Users
    def users()
    end

    def user_create()
    end

    def user_delete()
    end

    ## Flavors
    def flavors(id)
    end

    def address(endpoint)
      super(endpoint) + @accountid
    end
  end
end
