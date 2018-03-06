# frozen_string_literal: true
require 'spec_helper'

RSpec.describe GeoWorks::Derivatives::Processors::Rendering do
  subject(:processor) { TestProcessor.new }

  let(:output_file) { 'output/geo.png' }
  let(:file_name) { 'files' }
  let(:options) { { output_size: '150 200' } }
  let(:bounds) { { north: 40.0, east: -74.0, south: 40.0, west: -74.0 } }
  let(:info) { instance_double(GeoWorks::Derivatives::Processors::Vector::Info, name: 'test', bounds: bounds) }
  let(:config) do
    {
      'stroke' => '#483d8b',
      'line-cap' => 'square',
      'line-join' => 'miter',
      'weight' => '0.3',
      'fill' => '#e4e3ea',
      'radius' => '2'
    }
  end

  before do
    class TestProcessor
      include GeoWorks::Derivatives::Processors::Rendering
    end

    allow(GeoWorks::Derivatives::Processors::Vector::Info).to receive(:new).and_return(info)
    allow(GeoWorks::Derivatives::Config.rendering_config).to receive(:to_h).and_return(config)
    allow(GeoWorks::Derivatives::Config.rendering_config).to receive(:bg_color).and_return('#ffffff00')
    allow(Dir).to receive(:glob).and_return(['test.shp'])
  end

  after { Object.send(:remove_const, :TestProcessor) }

  describe '#vector_thumbnail' do
    before { allow(File).to receive(:open) }

    it 'saves a vector thumbnail using simpler tiles' do
      processor.class.vector_thumbnail(file_name, output_file, options)
      expect(File).to have_received(:open).with(output_file, 'wb')
    end
  end

  describe '#simple_tiles_map' do
    subject(:map) { described_class.simple_tiles_map(file_name, options) }

    it 'has a background color' do
      expect(map.bgcolor).to eq('#ffffff00')
    end

    it 'has a valid bounds property' do
      expect(map.bounds.to_wkt).to match(/-74.000000 40.000000/)
    end

    it 'has the correct width and height' do
      expect(map.width).to eq(150)
      expect(map.height).to eq(200)
    end

    it 'has a WGS 84 projection' do
      expect(map.srs).to eq('+proj=longlat +datum=WGS84 +no_defs ')
    end
  end
end
