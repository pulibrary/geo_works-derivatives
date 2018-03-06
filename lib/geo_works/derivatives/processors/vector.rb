# frozen_string_literal: true
module GeoWorks
  module Derivatives
    module Processors
      module Vector
        require 'geo_works/derivatives/processors/vector/base'
        require 'geo_works/derivatives/processors/vector/info'
        require 'geo_works/derivatives/processors/vector/shapefile'

        class Processor < Hydra::Derivatives::Processors::Processor
          def process
            vector_processor_class.new(source_path,
                                       directives,
                                       output_file_service: output_file_service).process
          end

          # Returns a vector processor class based on mime type passed in the directives object.
          # @return vector processing class
          def vector_processor_class
            case directives.fetch(:input_format)
            when 'application/zip; ogr-format="ESRI Shapefile"'
              GeoWorks::Derivatives::Processors::Vector::Shapefile
            else
              GeoWorks::Derivatives::Processors::Vector::Base
            end
          end
        end
      end
    end
  end
end
