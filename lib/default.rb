$:.unshift File.dirname(__FILE__)

require "nutils/filters/svg2png"
require "nutils/filters/beautify"

include Nanoc3::Helpers::HTMLEscape

require 'bluecloth'
require 'kramdown'

def md_to_html(content)
  ::BlueCloth.new(content).to_html
  # params = {}
  # ::Kramdown::Document.new(content, params).to_html
  # h content
end