require 'ropenstack/common/rest'

module Ropenstack
  ##
  # * Name: Database
  # * Description: Implementation of the Block Storage API Client in Ruby.
  # * Author: Sam 'Tehsmash' Betts
  # * Date: 01/15/2013
  ##
  class Database < OpenstackService
    ## Database Instances
    def instances(id)
    end

    def instance_create()
    end

    def instance_delete()
    end

    def instance_root(id)
    end

    def instance_root_enable(id)
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
  end
end
