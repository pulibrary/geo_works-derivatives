# frozen_string_literal: true
require 'geo_works/derivatives/version'
require 'hydra/derivatives'
require 'mime/types'

module GeoWorks
  module Derivatives
    require 'geo_works/derivatives/config'
    require 'geo_works/derivatives/processors'
    require 'geo_works/derivatives/runners'

    def self.root
      File.expand_path("../..", File.dirname(__FILE__))
    end
  end
end
