module Ropenstack::Compute::Version2::Extensions
  module Keypairs
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
