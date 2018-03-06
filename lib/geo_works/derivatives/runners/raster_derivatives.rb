# frozen_string_literal: true
module GeoWorks
  module Derivatives
    module Runners
      class RasterDerivatives < Hydra::Derivatives::Runner
        def self.processor_class
          GeoWorks::Derivatives::Processors::Raster::Processor
        end
      end
    end
  end
end
