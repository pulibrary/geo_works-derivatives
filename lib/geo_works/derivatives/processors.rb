# frozen_string_literal: true
module GeoWorks
  module Derivatives
    module Processors
      require 'geo_works/derivatives/processors/base_geo_processor'
      require 'geo_works/derivatives/processors/gdal'
      require 'geo_works/derivatives/processors/image'
      require 'geo_works/derivatives/processors/ogr'
      require 'geo_works/derivatives/processors/rendering'
      require 'geo_works/derivatives/processors/zip'
      require 'geo_works/derivatives/processors/raster'
      require 'geo_works/derivatives/processors/vector'
    end
  end
end
