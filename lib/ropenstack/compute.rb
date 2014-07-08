require 'ropenstack/common/rest'
require 'uri'

require 'ropenstack/compute/v2/extensions/quotasets'

module Ropenstack
=begin
	* Name: Compute
	* Description: Implementation of the Compute API Client in Ruby 
	* Author: Sam 'Tehsmash' Betts
	* Date: 01/15/2013
=end
  class Compute < OpenstackService
    ##
    # Gets a list of servers from OpenStack 
    #
    # :call-seq:
    #   servers(id) => A single server with the id matching the parameter
    #   servers() => All servers visible to the tenant making the request
    ##
    def servers(id)
      endpoint = "/servers"
      unless id.nil?
        endpoint = endpoint + "/" + id
      end
      return get_request(address(endpoint), @token)
    end 

    ##
    # Gets a more detailed list of servers from openstack.
    ##
    def servers_detailed()
      return get_request(address("/servers/detail"), @token)
    end

    ##
    # Creates a server on OpenStack.
    ##
    def create_server(name, image, flavor, networks = nil, keypair = nil, security_group = nil, metadata = nil)
      data = { 
        "server" => { 
          "name" => name,
          "imageRef" => image,
          "flavorRef" => flavor,
        }   
      }
      unless networks.nil?
        data["server"]["networks"] = networks 
      end
      unless keypair.nil?
        data["server"]["key_name"] = keypair
      end
      unless security_group.nil?
        data["server"]["security_group"] = security_group 
      end
      return post_request(address("/servers"), data, @token)
    end 

    ##
    # Deletes a server from Openstack based on an id
    ##
    def delete_server(id)
      return delete_request(address("/servers/" + id), @token)
    end

    ##
    # Perform an action on a server on Openstack, by passing an id, 
    # and an action, some actions require more data.
    #
    # E.g. action(id, "reboot", "hard")
    ##
    def action(id, act, *args) 
      data = case act
        when "reboot" then {'reboot' =>{"type" => args[0]}}	
        when "vnc" then {'os-getVNCConsole' => { "type" => "novnc" }} 
        when "stop" then {'os-stop' => 'null'}
        when "start" then {'os-start' => 'null'}
        when "pause" then {'pause' => 'null'}
        when "unpause" then {'unpause' => 'null'}
        when "suspend" then {'suspend' => 'null'}
        when "resume" then {'resume' => 'null'}
        when "create_image" then {'createImage' => {'name' => args[0], 'metadata' => args[1]}} 
        else raise "Invalid Action"
        end
      return post_request(address("/servers/" + id + "/action"), data, @token)
    end

    ##
    # Retrieve a list of images from Openstack through the nova endpoint
    ##
    def images() 
      uri = URI.parse("http://" + @location.host + ":9292/v2/images")
      return get_request(uri, @token)
    end

    ##
    # Delete an image stored on Openstack through the nova endpoint
    ##
    def delete_image(id)
      uri = URI.parse("http://" + @location.host + ":" + @location.port.to_s + "/v2/images/" + id)
      return delete_request(uri, @token)
    end

    ##
    # Get a list of flavors that Servers can be
    ##
    def flavors()
      return get_request(address("/flavors/detail"), @token)	
    end

    ##
    # Get a tenants compute quotas
    ##
    def limits()
      return get_request(address("/limits"), @token)
    end

    ##
    # Get a list of Compute Extensions
    ##
    def extensions(ali)
      if ali.nil?
        return get_request(address("/extensions"), @token)
      else 
        return get_request(address("/extensions/"+ ali), @token)
      end
    end

    def metadata(id, key)
      if key.nil?
        return get_request(address("/servers/"+id+"/metadata"), @token)
      else
        return get_request(address("/servers/"+id+"/metadata/" + key), @token)
      end
    end

    def set_metadata(id, data, key)
      if key.nil?
        return put_request(address("/servers/"+id+"/metadata"), data, @token)
      else
        return put_request(address("/servers/"+id+"/metadata/"+key), data, @token)
      end
    end

    def update_metadata(id, data)
      return post_request(address("/servers/"+id+"/metadata"), data, @token)
    end

    def delete_metadata(id, key)
      return delete_request(address("/servers/"+id+"/metadata/" + key), @token)
    end

    def ips(id, network)
      if network.nil?
        return get_request(address("/servers/"+id+"/ips"), @token) 
      else 
        return get_request(address("/servers/"+id+"/ips/" + network), @token) 
      end
    end
  end
end
