=begin
	* Name: Ropenstack
	* Description: Module used to wrap all Openstack service classes.
	* Author: Sam 'Tehsmash' Betts
	* Date: 01/15/2013
=end
module Ropenstack
  require 'ropenstack/identity/identity'
  require 'ropenstack/image/image'
  require 'ropenstack/blockStorage/blockStorage'
  require 'ropenstack/compute/compute'
  require 'ropenstack/compute/computeExtension'
  require 'ropenstack/networking/networking'
  require 'ropenstack/common/error'
end
