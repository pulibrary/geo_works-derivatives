# frozen_string_literal: true
module GeoWorks
  module Derivatives
    module Runners
      class VectorDerivatives < Hydra::Derivatives::Runner
        def self.processor_class
          GeoWorks::Derivatives::Processors::Vector::Processor
        end
      end
    end
  end
end
