module Nutils
  module Filters
    autoload "Beautify", "nutils/filters/beautify"
    autoload "Sprockets", "nutils/filters/sprockets"
    autoload "Svg2Png", "nutils/filters/svg2png"
    autoload "YuiCompressor", "nutils/filters/yuicompressor"

    ::Nanoc3::Filter.register "::Nutils::Filters::Beautify", :beautify
    ::Nanoc3::Filter.register "::Nutils::Filters::Sprockets", :sprockets
    ::Nanoc3::Filter.register "::Nutils::Filters::Svg2Png", :svg2png
    ::Nanoc3::Filter.register "::Nutils::Filters::YuiCompressor", :yuicompressor
  end
end