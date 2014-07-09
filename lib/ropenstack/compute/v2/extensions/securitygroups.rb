module Ropenstack::Compute::Version2::Extensions
  module SecurityGroups
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
  end
end
