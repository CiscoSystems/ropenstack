module Ropenstack
  module Compute::V2
    module Extensions
      # Pull in module extension files
      require "ropenstack/compute/v2/extensions/keypairs"
      require "ropenstack/compute/v2/extensions/securitygroups"

      # Include individual extensions so that if anyone wants to 
      # simply include all extensions they only have to include one file.
      include Keypairs
      include SecurityGroups
    end
  end
end
