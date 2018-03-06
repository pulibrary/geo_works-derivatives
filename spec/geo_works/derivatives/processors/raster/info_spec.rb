# frozen_string_literal: true
require 'spec_helper'
require 'open3'

RSpec.describe GeoWorks::Derivatives::Processors::Raster::Info do
  let(:processor) { described_class.new(path) }
  let(:path) { 'test.tif' }
  let(:info_doc) { read_test_data_fixture('files/gdalinfo.txt') }

  context 'when initializing a new info class' do
    before do
      allow(Open3).to receive(:capture3).and_return([info_doc, '', ''])
    end

    it 'shells out to gdalinfo and sets the doc variable to the output string' do
      expect(processor.doc).to eq(info_doc)
      expect(Open3).to have_received(:capture3).with("gdalinfo -mm #{path}")
    end
  end

  context 'after intialization' do
    before do
      allow(processor).to receive(:doc).and_return(info_doc)
    end

    describe '#min_max' do
      it 'returns with min and max values' do
        expect(processor.min_max).to eq('354.000 900.000')
      end
    end

    describe '#size' do
      it 'returns raster size' do
        expect(processor.size).to eq('310 266')
      end
    end
  end
end
