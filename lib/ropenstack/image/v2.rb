##
# * Name: ImageVersion2
# * Description: Implementation of the Glance V2.0 API Client in Ruby
# * Author: Sam 'Tehsmash' Betts, John Davidge
# * Date: 30/06/2014
##
module ImageVersion2
  ##
  # Returns a list of images with all associated meta-data in 
  # hash format.
  ##
  def images(id)
    if id.nil?
      return get_request(v2_address("images"), @token)["images"]
    else
      return get_request(v2_address("images/" + id), @token)
    end
  end

  def image_create(name, id, visibilty, tags)
    data = { 
      :name => name
    }
    unless id.nil?
      data[:id] = id
    end
    unless visibility.nil?
      data[:visibility] = visibility
    end
    unless tags.nil?
      data[:tags] = tags
    end

    post_request(v2_address("images"), data, @token)
  end

  def image_delete(id)
    delete_request(v2_address("images/" + id), @token)
  end

  # TODO Ruby HTTP Binary Download to FILE
  def image_download(id)
  end

  def image_add_tag(id, tag)
    put_request(v2_address("images/"+id+"/tags/"+tag), @token)
  end

  def image_delete_tag(id)
    delete_request(v2_address("images/"+id+"/tags/"+tag), @token)
  end

  ## Members
  def members(id)
  end

  def member_add()
  end

  def member_delete()
  end

  def member_update()
  end

  ## Schemas
  def schemas(type)
    return get_request(v2_address("schemas/" + type), @token)
  end


  ## BELOW HERE IS OLD CODE THAT MAY OR MAYNOT WORK, THAR BE DRAGONS

  ##
  # Upload an image to the Image Service from a file, takes in a ruby file object. 
  # More convoluted than it should be because for a bug in Quantum
  # which just returns an error no matter the outcome.
  ## 
  def upload_image_from_file(name, disk_format, container_format, minDisk, minRam, is_public, file)
    data = {
      "name" => name,
      "disk_format" => disk_format,
      "container_format" => container_format,
      "minDisk" => minDisk,
      "minRam" => minRam,
      "public" => is_public
    }
    imagesBefore = images()
    post_request(v2_address("images"), data, @token, false)
    imagesAfter = images()
    foundNewImage = true
    image = nil
    imagesAfter.each do |imageA|
      imagesBefore.each do |imageB|
        if(imageA == imageB)
          foundNewImage = false				
        end
      end
      if(foundNewImage)
        image = imageA
        break
      end
    end
    return put_octect(address(image["file"]), file.read, false)
  end		
  
  ##
  # Special rest call for sending a file stream using an octet-stream
  # main change is just custom headers.
  # Still implemented using do_request function.  
  ## 
  def put_octect(uri, data, manage_errors)
    headers = build_headers(@token)
    headers["Content-Type"] = 'application/octet-stream'	
    req = Net::HTTP::Put.new(uri.request_uri, initheader = headers)
    req.body = data
    return do_request(uri, req, manage_errors, 0)
  end

  private

  ##
  # Function to use to get the v2 address location of an endpoint
  # because some quantum calls change version.
  ##
  def v2_address(endpoint)
    address("/v2/#{endpoint}")
  end

  ##
  # Function to use to get the v1 address location of an endpoint
  # because some quantum calls change version.
  ##
  def v1_address(endpoint)
    address("/v1/#{endpoint}")
  end

  def version()
    "V2"
  end
end
