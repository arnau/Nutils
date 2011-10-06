# encoding: utf-8

module Nutils

  # The current nutils version.
  VERSION = '1.0.0'
end

# Load requirements
require 'nanoc3'

# Load nutils
require 'nutils/base'
require 'nutils/data_sources'
require 'nutils/filters'
require 'nutils/helpers'
require 'nutils/filters/sass'