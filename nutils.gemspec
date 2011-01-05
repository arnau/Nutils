# encoding: utf-8
require "rubygems"

$:.unshift File.expand_path(File.dirname(__FILE__) + '/lib')
require "nutils"

Gem::Specification.new do |spec|
  spec.name = "nutils"
  spec.version = Nutils::VERSION
  spec.summary = "A set of utilities for Nanoc3."
  spec.description = "Nutils is a set of utilities like filters, data_sources and helpers for Nanoc3."
  spec.required_ruby_version = ">= 1.8.7"
  spec.author = "Arnau Siches"
  spec.email = "arnau.siches@gmail.com"
  spec.homepage = "http://github.com/arnau/Nutils/"
  
  # spec.test_file = "tests/test_nutils.rb"

  spec.files = Dir["lib/nutils/**/*"] + ["lib/nutils.rb"]

  spec.has_rdoc = "yard"
  spec.rdoc_options = ["--main", "README.md"]
  spec.extra_rdoc_files = ["README.md"]

  spec.add_dependency "nanoc3", ">= 3.1.2"
  spec.add_dependency "rjb", ">= 1.2.9"
  spec.add_dependency "yui-compressor", ">= 0.9.1"
  spec.add_dependency "htmlbeautifier"
  spec.add_dependency "sprockets"
  spec.add_dependency "rmagick"

end
