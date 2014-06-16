require 'ropenstack/common/rest'
require 'uri'

module Ropenstack
=begin
	* Name: Orchestration
	* Description: Implementation of the Orchestration API Client in Ruby 
	* Author: Sam 'Tehsmash' Betts
	* Date: 01/15/2013
=end
  class Orchestration < OpenstackService
    def stacks(name, id)
      if name.nil?
        get_request(address("/stacks"), @token)
      elsif id.nil?
        get_request(address("/stacks/"+name), @token)
      else
        get_request(address("/stacks/"+name+"/"+id), @token)
      end
    end

    def stack_create(name, template, isURL, environmment, files, parameters, timeout, disable, adoptData, preview)
      data = { 
        :stack_name => name,
        :environment => environment, 
        :timeout_mins => timeout, 
        :files => files,
        :parameters => parameters,
        :disable => disable
      }
      if isURL
        data[:template_url] = template
      else
        data[:template] = template
      end
      unless adoptData.nil? 
        data[:adopt_stack_data] = adoptData
      end
      post_request(address("/stacks"), data, @token)
    end

    def stack_update(name, id)
      put_request(address("/stack/"+name+"/"+id+"/action"), {:resume => nil}, @token)
    end

    def stack_delete(name, id)
      delete_request(address("/stack/"+name+"/"+id), @token)
    end

    def stack_adandon(name, id, preview)
      if preview
        get_request(address("/stack/" + name + "/"+ id + "/abandon"), @token)
      else
        delete_request(address("/stack/" + name + "/"+ id + "/abandon"), @token)
      end
    end

    def stack_action(name, id, action)
      case action
      when "SUSPEND"
        post_request(address("/stack/"+name+"/"+id+"/action"), {:suspend => nil}, @token)
      when "RESUME"
        post_request(address("/stack/"+name+"/"+id+"/action"), {:resume => nil}, @token)
      else
        raise Ropenstack::RopenstackError, "Invalid Action Passed"
      end
    end

    def resources(stack, id = nil, name = nil, meta = false)
      if id.nil?
        get_request(address("/stacks/"+stack+"/resources"), @token)
      elsif name.nil?
        get_request(address("/stacks/"+stack+"/"+id+"/resources"), @token)
      else
        if meta 
          get_request(address("/stacks/"+stack+"/"+id+"/resources/"+name+"/metadata"), @token)
        else
          get_request(address("/stacks/"+stack+"/"+id+"/resources/"+name), @token)
        end
      end 
    end

    def resource_types(name = nil)
      if name.nil?
        get_request(address("/resource_types"), @token)
      else
        get_request(address("/resource_types/"+name), @token)
      end
    end

    def resource_type_template(name)
      get_request(address("/resource_types/"+name+"/template"), @token)
    end

    def events(stack, id = nil, resource = nil, event = nil)
      if id.nil?
        get_request(address("/stacks/"+stack+"/events"), @token)
      elsif resource.nil?
        get_request(address("/stacks/"+stack+"/"+id+"/events"), @token)
      elsif event.nil?
        get_request(address("/stacks/"+stack+"/"+id+"/resources/"+resource+"/events"), @token)
      else
        get_request(address("/stacks/"+stack+"/"+id+"/resources/"+resource+"/events/"+event), @token)
      end 
    end

    def stack_template(name, id)
      get_request(address("/stacks/" + name + "/" + id), @token)
    end

    def validate_template(template, isURL)
      data = {}
      if isURL
        data[:template_url] = template
      else
        data[:template] = template
      end
      post_request(address("/validate"), data, @token)
    end

    def build_info
      get_request(address("/build_info"), @token)
    end

    def software_configs(id)
      get_request(address("/software_configs/" + id), @token)
    end

    # TODO
    def create_software_config
    end

    def delete_software_config(id)
      delete_request(address("/software_configs/" + id), @token)
    end

    def software_deployments(id = nil)
      if id.nil?
        get_request(address("/software_deployments"), @token)
      else
        get_request(address("/software_deployments/" + id), @token)
      end
    end

    def server_software_deployment(server)
      get_request(address("/software_deployments/metadata/"+server), @token)
    end

    # TODO 
    def create_software_deployment
    end

    # TODO 
    def update_software_deployment(id)
    end

    def delete_software_deployment(id)
      delete_request(address("/software_deployments/" + id), @token)
    end
  end
end
