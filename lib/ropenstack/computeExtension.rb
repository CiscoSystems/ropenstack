require 'ropenstack/rest'
require 'uri'

module Ropenstack
=begin
	* Name: ComputeExtension
	* Description: Implementation of the ComputeExtension API Client in Ruby 
	* Author: Sam 'Tehsmash' Betts
	* Date: 01/15/2013
=end
  class ComputeExtension < OpenstackService
    ##
    # Attach a cinder volume to a server, by passing the server id and
    # the volume id.
    ##
    def attach_volume(id, volume) 
      data = { 'volumeAttachment' => { 'volumeId' => volume, 'device' => "/dev/vdb" } }
      return post_request(address("/servers/" + id + "/os-volume_attachments"), data, @token)
    end
    
    ##
    # Remove a cinder volume from a server, by passing the server id and
    # the attachment id.
    ##
    def detach_volume(id, attachment)
      return delete_request(address("/servers/"+id+"/os-volume_attachments/"+volume), @token)
    end

    def security_groups(id = nil)
      endpoint = "/os-security-groups"
      unless id.nil?
        endpoint = "#{endpoint}/#{id}"
      end
      return get_request(address(endpoint), @token)
    end

    def create_security_group(name, description)
      data = { "security_group" => {"name" => name, "description" => description } }
      return post_request(address("/os-security-groups"), data, @token)
    end

    def destroy_security_group(id)
      return post_request(address("/os-security-groups/#{id}"), @token)
    end

    def create_security_group_rule(protocol, from, to, cidr, parent, group = nil)
      data = { 
        "security_group_rule" => {
          "ip_protocol" => protocol,
          "from_port" => from,
          "to_port" => to,
          "cidr" => cidr,
          "parent_group_id" => parent
        } 
      }
      unless group.nil?
        data["security_group_rule"]["group_id"] = group
      end
      return post_request(address("/os-security-group-rules"), data, @token)
    end

    def destroy_security_group_rule(id)
      return delete_request(address("/os-security-group-rules/#{id}"), @token)
    end

    def keypairs(name = nil)
      endpoint = "/os-keypairs" 
      unless name.nil?
        endpoint = "#{endpoint}/#{name}"
      end
      return get_request(address(endpoint), @token)
    end

    def create_keypair(name)
      data = { "keypair" => { "name" => name } }
      return post_request(address("/os-keypairs"), data, @token)
    end

    def delete_keypair(name)
      return delete_request(address("/os-keypairs/#{name}"), @token)
    end
  end
end
