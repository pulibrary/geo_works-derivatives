# frozen_string_literal: true
require 'byebug'
require 'spec_helper'
require 'fileutils'

RSpec.describe GeoWorks::Derivatives::Runners::RasterDerivatives do
  describe "#create" do
    let(:display_raster_uri) { test_derivative_url('display_raster', 'tif') }
    let(:thumbnail_uri) { test_derivative_url('thumbnail', 'png') }
    let(:outputs) do
      [
        {
          input_format: input_mime_type,
          label: :display_raster,
          id: 'file_set_id',
          format: 'tif',
          url: display_raster_uri
        },
        {
          input_format: input_mime_type,
          label: :thumbnail,
          id: 'file_set_id',
          format: 'png',
          size: '200x150',
          url: thumbnail_uri
        }
      ]
    end

    before do
      described_class.source_file_service = LocalFileService
      described_class.output_file_service = OutputFileService
    end

    after do
      # Cleanup generated derivatives
      FileUtils.rm(display_raster_uri.path)
      FileUtils.rm(thumbnail_uri.path)
    end

    context "with a geotiff" do
      let(:input_file_path) { Pathname.new(test_data_fixture_path('files/raster/geotiff.tif')) }
      let(:input_mime_type) { 'image/tiff; gdal-format=GTiff' }

      it_behaves_like "a set of raster derivatives"
    end

    context "with an ArcGrid file" do
      let(:input_file_path) { Pathname.new(test_data_fixture_path('files/raster/arcgrid.zip')) }
      let(:input_mime_type) { 'application/octet-stream; gdal-format=AIG' }

      it_behaves_like "a set of raster derivatives"
    end

    context "with a digital elevation model file" do
      let(:input_file_path) { Pathname.new(test_data_fixture_path('files/raster/example.dem')) }
      let(:input_mime_type) { 'text/plain; gdal-format=USGSDEM' }

      it_behaves_like "a set of raster derivatives"
    end
  end
end
