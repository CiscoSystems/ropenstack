=begin
	* Name: Ropenstack
	* Description: Module used to wrap all Openstack service classes.
	* Author: Sam 'Tehsmash' Betts
	* Date: 01/15/2013
=end
module Ropenstack
  require 'ropenstack/blockStorage'
  require 'ropenstack/compute'
  require 'ropenstack/database'
  require 'ropenstack/identity'
  require 'ropenstack/image'
  require 'ropenstack/networking'
  require 'ropenstack/objectStorage'
  require 'ropenstack/orchestration'
  require 'ropenstack/telemetry'
  require 'ropenstack/common/error'
end
