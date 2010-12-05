# encoding: utf-8
require "rubygems"

Gem::Specification.new do |spec|
  spec.name = "nutils"
  spec.version = "0.5.0"
  spec.summary = "A set of utilities for Nanoc3."
  spec.description = "Nutils is a set of utilities like filters, data_sources and helpers for Nanoc3."
  spec.required_ruby_version = ">= 1.8.7"
  spec.author = "Arnau Siches"
  spec.email = "arnau.siches@gmail.com"
  spec.homepage = "http://github.com/arnau/nutils/"
  
  # spec.test_file = "tests/test_nutils.rb"

  spec.files = Dir["lib/nutils/**/*"]
  spec.require_paths = ["lib/nutils"]

  spec.has_rdoc = "yard"
  spec.rdoc_options = ["--main", "README"]
  spec.extra_rdoc_files = ["README"]

  spec.add_dependency "nanoc3", ">= 3.1.2"
  spec.add_dependency "rjb", ">= 1.2.9"

end
