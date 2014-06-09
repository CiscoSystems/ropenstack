module Ropenstack
  ##
  # * Name: ObjectStorage
  # * Description: Implementation of the Block Storage API Client in Ruby.
  # * Author: Sam 'Tehsmash' Betts
  # * Date: 01/15/2013
  ##
  class ObjectStorage < OpenstackService
    ## Accounts

    def account(id, head)
    end

    def create_account()
    end

    ## Containers
    
    def container(account, container, head)
    end

    def create_container(account, container)
    end

    def delete_container(account, container)
    end

    def update_container(account, container)
    end
    
    ## Objects

    def object(account, container, object)
    end

    def create_object(account, container, object)
    end

    def copy_object(account, container, object)
    end

    def delete_object(account, container, object)
    end

    def object_metadata(account, container, object)
    end
    
    def create_object_metadata(account, container, object)
    end
end
