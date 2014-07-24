module Ropenstack
  ##
  # * Name: ImageVersion1
  # * Description: Implementation of the Glance V1.0 API Client in Ruby
  # * Author: Sam 'Tehsmash' Betts, John Davidge
  # * Date: 30/06/2014
  ##
  module Image::Version1

    ##
    # No ID provided - Lists details for available images.
    # ID provided - Shows the image details as headers and the image binary in the body.
    ##
    def images(id, tenant_id)
      if id.nil?
        return get_request(address(tenant_id, "images/detail"), @token)
      else
        return get_request(address(tenant_id, "images/" + id), @token)
      end
    end

    ##
    # Registers a virtual machine image.
    ##
    def image_create(name, disk_format, container_format, create_image, tenant_id)
      data = { 
        :name => name,
        :disk_format => disk_format,
        :container_format => container_format
      }
      unless create_image.nil?
        data[:create_image] = create_image
      end

      post_request(address(tenant_id, "images"), data, @token)
    end

    ##
    # Updates an image, uploads an image file, or updates metadata for an image.
    # NOT IMPLEMENTED
    ##
    def image_update(id, tenant_id)
      raise Ropenstack::RopenstackError, "Update Method Not Implemented."
    end

    ##
    # Deletes the specified image.
    ##
    def image_delete(id, tenant_id)
      delete_request(address(tenant_id, "images/" + id), @token)
    end

    ##
    # Replaces the membership list for an image.
    # @param memberships List of memberships in format [{'member_id': 'tenant1', 'can_share': 'false'}]
    ##
    def replace_memberships(id, memberships, tenant_id)
      data = {
        :memberships => memberships
      }
      put_request(address(tenant_id, "images/" + id + "/members"), data, @token)
    end

    ##
    # Adds a member to an image.
    # @param member_id The member to be added
    # @param can_share Optional boolean specifiying can_share value. Will default to false.
    ##
    def add_member(id, member_id, can_share, tenant_id)
      if can_share.nil?
        data = {
          :member => {:can_share => false}
        }
      else
        data = {
          :member => {:can_share => can_share}
        }
      end
      put_request(address(tenant_id, "images/" + id + "/members/" + member_id), data, @token)
    end

    ##
    # Removes a member from an image
    ##
    def delete_member(id, member_id, tenant_id)
      delete_request(address(tenant_id, "images/" + id + "/members/" + member_id), @token)
    end

    ##
    # Lists the images shared with a specified owner.
    ##
    def shared_images(id, owner_id, tenant_id)
      get_request(address(tenant_id, "shared-images/" + owner_id), @token)
    end

    ##
    # Returns the v1 address location of an endpoint.
    ##
    def address(tenant_id, endpoint)
      address("/v1/#{tenant_id}/#{endpoint}")
    end

    def version
      "V1"
    end
  end
end
