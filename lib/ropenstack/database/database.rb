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

    def instance_create(databases, flavorRef, name, users, volume)
      ## Construct data
      data = { :instance => {
          :databases => databases,
          :flavorRef => flavorRef, 
          :name => name,
          :users => users,
          :volume => volume
        }
      }

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
      case action
      when "RESTART" 
        post_request(address("/instances/" + id + "/action"), {:restart => {}}, @token)
      when "RESIZE"
        if param.is_a? String
          post_request(address("/instances/" + id + "/action"), {:resize => {:flavorRef => param }}, @token)
        elsif param.is_a? Int
          post_request(address("/instances/" + id + "/action"), {:resize => {:volume => {:size => param }}}, @token)
        else
          raise Ropenstack::RopenstackError, "Invalid Parameter Passed"
        end
      else
        raise Ropenstack::RopenstackError, "Invalid Action Passed"
      end
    end

    ## Databases
    def databases(instance)
      get_request(address("/instances/" + instance + "/databases"), @token)
    end

    def database_create(instance, name)
      data = { :databases => [
          {
            :name => name
          }
        ]
      }
      post_request(address("/instances/" + instance + "/databases"), data, @token)
    end

    def database_delete(instance, name)
      delete_request(address("/instances/" + instance + "/databases/" + name), @token)
    end

    ## Users
    def users(instance)
      get_request(address("/instances/" + instance + "/users"), @token)
    end

    def user_create(instance, name, databases)
      ## TODO Make this work
      post_request(address("/instances/" + instance + "/users"), data, @token)
    end

    def user_delete(instance, name)
      post_request(address("/instances/" + instance + "/users/" + name), @token)
    end

    ## Flavors
    def flavors(id)
      if id.nil? 
        get_request(address("/flavors"), @token)
      else
        get_request(address("/flavors/" + id), @token)
      end
    end

    def address(endpoint)
      super(endpoint) + @accountid
    end
  end
end
