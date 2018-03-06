# frozen_string_literal: true
require 'spec_helper'

RSpec.describe GeoWorks::Derivatives::Processors::BaseGeoProcessor do
  let(:processor) { TestProcessor.new }

  before do
    class TestProcessor
      include GeoWorks::Derivatives::Processors::BaseGeoProcessor
      include GeoWorks::Derivatives::Processors::Gdal
      def directives; end

      def source_path; end
    end

    allow(processor).to receive(:directives).and_return(directives)
    allow(processor).to receive(:source_path).and_return(file_name)
  end

  after { Object.send(:remove_const, :TestProcessor) }

  let(:directives) { { format: 'png', size: '200x400' } }
  let(:output_file_jpg) { 'output/geo.jpg' }
  let(:output_file_png) { 'output/geo.png' }
  let(:output_file) { output_file_png }
  let(:file_name) { 'files/geo.tif' }
  let(:options) { { output_size: '150 150' } }

  describe '#run_commands' do
    let(:method_queue) { [:translate, :warp, :compress] }

    context 'when the processor raises an error' do
      before do
        allow(method_queue).to receive(:empty?).and_raise('error')
        allow(Dir).to receive(:exist?).and_return(true)
        allow(FileUtils).to receive(:rm_rf)
      end

      it 'cleans the derivative intermediates' do
        expect { processor.class.run_commands(file_name, output_file, method_queue, options) }.to raise_error('error')
        expect(FileUtils).to have_received(:rm_rf).twice
      end
    end
  end
end
