module Ropenstack::Compute::Version2::Extensions
  module Volumes
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
  end
end
