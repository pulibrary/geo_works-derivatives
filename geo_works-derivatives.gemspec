# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "geo_works/derivatives/version"

Gem::Specification.new do |spec|
  spec.name          = 'geo_works-derivatives'
  spec.version       = GeoWorks::Derivatives::VERSION
  spec.authors       = ['Eliot Jordan']
  spec.email         = ['eliotj@princeton.edu']

  spec.summary       = 'Geospatial derivative generation'
  spec.description   = 'Hydra::Derivatives compatible processors for Geospatial derivative generation'
  spec.homepage      = 'https://github.com/pulibrary/geo_works-derivatives'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'hydra-derivatives'
  spec.add_dependency 'mime-types'
  spec.add_dependency 'simpler-tiles'

  spec.add_development_dependency 'bixby'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
