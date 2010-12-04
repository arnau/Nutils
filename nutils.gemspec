require "rubygems"

Gem::Specification.new do |spec|
  spec.name = "nutils"
  spec.version = "0.5.0"
  spec.summary = "A set of utilities for Nanoc3."
  spec.description = "This set of utilities contains filters, data_sources and helpers."
  spec.required_ruby_version = ">= 1.8.7"
  spec.author = "Arnau Siches"
  spec.email = "arnau.siches@gmail.com"
  spec.homepage = "http://github.com/arnau/nutils/"
  
  # spec.test_file = "tests/test_nutils.rb"

  spec.has_rdoc = false
  
  spec.files = Dir.glob("lib/nutils/**/*")
  spec.require_paths = ["lib/nutils"]
  spec.add_dependency "nanoc3 >= 3.1.2"
  spec.add_dependency "rjb"
  spec.add_dependency "tempfile"

end
