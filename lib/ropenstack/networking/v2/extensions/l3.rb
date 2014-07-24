module Ropenstack::Networking::Version2::Extensions
  module L3
    ##
    # Get a list of a tenants routers
    # 
    # :call-seq:
    #   routers(id) => A single router with the id matching the parameter
    #   routers => All routers visible to the tenant making the request
    ##
    def routers(id = nil)
      endpoint = "routers"
      unless id.nil?
        endpoint = endpoint + "/" + id
      end
      return get_request(address(endpoint), @token)
    end 
    ##
    # Create a new router with a given name.
    ##
    def create_router(name, admin_state_up = true)
      data = {
        'router' =>{
          'name' => name,
          'admin_state_up' => admin_state_up,
        }   
      }
      return post_request(address("routers"), data, @token)
    end 

    ##
    # Delete a router given a routers id.
    ##
    def delete_router(router)
      return delete_request(address("routers/" + router), @token)
    end

    ##
    # Connect a router to a subnet, given router id and subnet id.
    ##
    def add_router_interface(router, subnet)
      data = { 'subnet_id' => subnet } 
      return put_request(address("routers/"+router+"/add_router_interface"), data, @token)
    end
    
    ##
    # Delete a connection between a subnet and router given either port
    # or subnet ids.
    #
    # :call-seq:
    #   delete_router_interface(router_id, subnet_id, "subnet")
    #   delete_router_interface(router_id, port_id, "port")
    ##
    def delete_router_interface(router, id, type)
      data = case type
        when 'port' then { 'port_id' => id }
        when 'subnet' then { 'subnet_id' => id } 
        else raise "Invalid Interface Type"  
        end
      return put_request(address("routers/" + router + "/remove_router_interface"), data, @token)
    end

    ##
    # Enable external connectivity through this router by connecting it to
    # an "external network"
    ##
    def add_router_gateway(router, network_id)
      data = { 'router' => {'external_gateway_info' => { 'network_id' => network_id }}}
      return put_request(address("routers/"+router), data, @token)
    end

    ##
    # Clear a routers external gateway information given a router id.  
    ##
    def delete_router_gateway(router)
      data = { 'router' => {'external_gateway_info' => nil}}
      return put_request(address('routers/' + router), data, @token)
    end

    ##
    # Get a full list of floating ips for the tenant
    ##
    def floating_ips
      return get_request(address("floatingips"), @token)
    end

    def create_floating_ip(network, port = nil)
      data = {
        'floatingip' => {
          'floating_network_id' => network
        }
      }
      unless port.nil?
        data['floatingip']['port_id'] = port
      end
      return post_request(address('floatingips'), data, @token)
    end

    def delete_floating_ip(id)
      return delete_request(address("floatingips/#{id}"), @token)
    end

    def update_floating_ip(id, port)
      data = {
        'floatingip' => {
          'port_id' => port
        }
      }
      return put_request(address("floatingips/#{id}"), data, @token)
    end
  end
end
