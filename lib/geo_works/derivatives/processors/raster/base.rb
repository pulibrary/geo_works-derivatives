# frozen_string_literal: true
module GeoWorks
  module Derivatives
    module Processors
      module Raster
        class Base < Hydra::Derivatives::Processors::Processor
          include Hydra::Derivatives::Processors::ShellBasedProcessor
          include GeoWorks::Derivatives::Processors::BaseGeoProcessor
          include GeoWorks::Derivatives::Processors::Image
          include GeoWorks::Derivatives::Processors::Gdal

          def self.encode(path, options, output_file)
            case options[:label]
            when :thumbnail
              encode_raster(path, output_file, options)
            when :display_raster
              reproject_raster(path, output_file, options)
            end
          end

          # Set of commands to run to encode the raster thumbnail.
          # @return [Array] set of command name symbols
          def self.encode_queue
            [:translate, :convert, :trim, :center]
          end

          # Set of commands to run to reproject the raster.
          # @return [Array] set of command name symbols
          def self.reproject_queue
            [:warp, :force_rgb, :cloud_optimized_geotiff]
          end

          def self.encode_raster(in_path, out_path, options)
            run_commands(in_path, out_path, encode_queue, options)
          end

          def self.reproject_raster(in_path, out_path, options)
            run_commands(in_path, out_path, reproject_queue, options)
          end
        end
      end
    end
  end
end
