# encoding: utf-8

module Nutils

  # The current nutils version.
  VERSION = '0.11.2'

end

# Load requirements
require 'nanoc3'

# Load nutils
require 'nutils/base'
require 'nutils/data_sources'
require 'nutils/filters'
require 'nutils/helpers'