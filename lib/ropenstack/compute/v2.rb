module Ropenstack
  module Compute::Version2
    require "ropenstack/compute/v2/extensions"
    include Extensions

    # Insert V2 Specfic Code here 
    def version
      "V2"
    end
  end
end
