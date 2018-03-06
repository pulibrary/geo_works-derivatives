# frozen_string_literal: true
module GeoWorks
  module Derivatives
    module Processors
      module Raster
        require 'geo_works/derivatives/processors/raster/base'
        require 'geo_works/derivatives/processors/raster/aig'
        require 'geo_works/derivatives/processors/raster/dem'
        require 'geo_works/derivatives/processors/raster/info'

        class Processor < Hydra::Derivatives::Processors::Processor
          def process
            raster_processor_class.new(source_path,
                                       directives,
                                       output_file_service: output_file_service).process
          end

          # Returns a raster processor class based on mime type passed in the directives object.
          # @return raster processing class
          def raster_processor_class
            case directives.fetch(:input_format)
            when 'text/plain; gdal-format=USGSDEM'
              GeoWorks::Derivatives::Processors::Raster::Dem
            when 'application/octet-stream; gdal-format=AIG'
              GeoWorks::Derivatives::Processors::Raster::Aig
            else
              GeoWorks::Derivatives::Processors::Raster::Base
            end
          end
        end
      end
    end
  end
end
