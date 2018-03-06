# frozen_string_literal: true
module GeoWorks
  module Derivatives
    module Processors
      module Vector
        class Base < Hydra::Derivatives::Processors::Processor
          include Hydra::Derivatives::Processors::ShellBasedProcessor
          include GeoWorks::Derivatives::Processors::BaseGeoProcessor
          include GeoWorks::Derivatives::Processors::Image
          include GeoWorks::Derivatives::Processors::Ogr
          include GeoWorks::Derivatives::Processors::Gdal
          include GeoWorks::Derivatives::Processors::Rendering
          include GeoWorks::Derivatives::Processors::Zip

          def self.encode(path, options, output_file)
            case options[:label]
            when :thumbnail
              encode_vector(path, output_file, options)
            when :display_vector
              reproject_vector(path, output_file, options)
            end
          end

          # Set of commands to run to encode the vector thumbnail.
          # @return [Array] set of command name symbols
          def self.encode_queue
            [:reproject, :vector_thumbnail, :trim, :center]
          end

          # Set of commands to run to reproject the vector.
          # @return [Array] set of command name symbols
          def self.reproject_queue
            [:reproject, :zip]
          end

          def self.encode_vector(in_path, out_path, options)
            run_commands(in_path, out_path, encode_queue, options)
          end

          def self.reproject_vector(in_path, out_path, options)
            run_commands(in_path, out_path, reproject_queue, options)
          end
        end
      end
    end
  end
end
