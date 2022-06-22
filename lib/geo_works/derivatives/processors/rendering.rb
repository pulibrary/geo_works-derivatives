# frozen_string_literal: true

module GeoWorks
  module Derivatives
    module Processors
      module Rendering
        extend ActiveSupport::Concern
        included do
          # Renders a thumbnail from a vector dataset.
          # @param in_path [String] file input path
          # @param out_path [String] processor output file path
          # @param options [Hash] creation options
          def self.vector_thumbnail(in_path, out_path, options)
            size = options[:output_size].split(' ').map(&:to_i)
            Dir.glob("#{in_path}/*.shp").each do |shape_path|
              execute mapnik_command(size[0], size[1], shape_path, out_path)
            end
          end

          def self.mapnik_command(width, height, shape_path, out_path)
            "#{GeoWorks::Derivatives.root}/bin/thumbnail #{width} #{height} #{shape_path} #{out_path} '#{stylesheet(shape_path)}'"
          end

          def self.stylesheet(shapefile_path)
            path = ENV["MAPNIK_TEMPLATE_PATH"] || "#{GeoWorks::Derivatives.root}/config/mapnik.xml"
            template = File.read(path)
            template.gsub("{{path}}", shapefile_path)
          end
        end
      end
    end
  end
end
