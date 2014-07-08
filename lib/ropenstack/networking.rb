require 'ropenstack/networking/v2/extensions/l3'
require 'ropenstack/networking/v2/extensions/lbaas'
require 'ropenstack/networking/v2/extensions/metering'
require 'ropenstack/networking/v2/extensions/quotas'
require 'ropenstack/networking/v2/extensions/securitygroups'

module Ropenstack
=begin
	* Name: Networking
	* Description: An implementation of the Networking V2.0 API Client in Ruby
	* Authors: Sam 'Tehsmash' Betts, John Davidge
	* Date: 01/15/2013
=end
  class Networking < OpenstackService
    ## Extensions
    extend L3
    extend LBaaS
    extend Metering
    extend Quotas
    extend SecurityGroups

    ## Networks

    ##
    # Get a list of a tenants networks
    # 
    # :call-seq:
    #   networks(id) => A single network with the id matching the parameter
    #   networks => All networks visible to the tenant making the request
    ##
    def networks(id = nil)
      endpoint = "networks"
      unless id.nil?
        endpoint = endpoint + "/" + id
      end
      return get_request(address(endpoint), @token)
    end 

    ##
    # Create a new network on Openstack given a name and tenant id.
    ## 
    def create_network(name, tenant, admin_state_up = true)
      data = {
        'network' => {
          'name' => name,
          'tenant_id' => tenant,
          'admin_state_up' => admin_state_up
        }   
      }
      return post_request(address("networks"), data, @token)
    end 
    
    ##
    # Delete a network given a network id.
    ##
    def delete_network(network)
      return delete_request(address("networks/" + network), @token)
    end 

    ## Subnets

    ##
    # Get a list of subnets 
    ##
    def subnets
      return get_request(address("subnets"), @token)
    end 
    
    ##
    # Create a new ipv4 subnet in a network, given a network id, and
    # a IP range in CIDR format.
    ##
    def create_subnet(network, cidr)
      data = {
        'subnet' => {
          'network_id' => network,
          'ip_version' => 4,
          'cidr' => cidr
        }   
      }
      return post_request(address("subnets"), data, @token)
    end 

    ##
    # Delete a subnet given a subnet id
    ##
    def delete_subnet(subnet)
      return delete_request(address("subnets/" + subnet), @token)
    end

    ## Ports

    ##
    # Get a list of ports
    ##
    def ports
      return get_request(address("ports"), @token)
    end 

    ##
    # Get a list of ports specific to a device_id
    ##
    def device_ports(device_id)
      return get_request(address("ports?device_id=#{device_id}"), @token)
    end 

    ##
    # Create a new port given network and device ids, optional 
    # parameter subnet id allows for scoping the port to a single subnet. 
    ##
    def create_port(network, subnet = nil, device = nil, device_owner = nil)
      data = {
        'port' => {
          'network_id' => network,
        }   
      }
      unless device_owner.nil?
        data['port']['device_owner'] = device_owner
      end
      unless device.nil?
        data['port']['device_id'] = device
      end
      unless subnet.nil?
        data['port']['fixed_ips'] = [{'subnet_id' => subnet}]
      end
  
      puts data

      return post_request(address("ports"), data, @token)
    end 

    ##
    # Update a specific ports fixed_ips, including subnet and ip data.
    ##
    def update_port(port, fixed_ips) 
      data = { 'port' => { 'fixed_ips' => fixed_ips } }
      return put_request(address("ports/"+port), data, @token)
    end

    ##
    # Weird function for adding a port to multiple subnets if nessessary.
    ##
    def move_port_to_subnets(port_id, subnet_ids)
      id_list = Array.new()
      subnet_ids.each do |id|
        id_list << { "subnet_id" => id }
      end
      return update_port(port_id, id_list)
    end

    ##
    # Delete a port given a port id.
    ##
    def delete_port(port)
      return delete_request(address("ports/" + port), @token)
    end

    private

    def address(endpoint)
      super("/v2.0/#{endpoint}")
    end
  end
end
