module Nutils
  module Filters
    autoload "Beautify", "nutils/filters/beautify"
    autoload "Sprockets", "nutils/filters/sprockets"
    autoload "SvgToPng", "nutils/filters/svg2png"
    autoload "YuiCompressor", "nutils/filters/yuicompressor"

    ::Nanoc3::Filter.register "::Nutils::Filters::Beautify", :beautify
    ::Nanoc3::Filter.register "::Nutils::Filters::Sprockets", :sprockets
    ::Nanoc3::Filter.register "::Nutils::Filters::SvgToPng", :svg_to_png
    ::Nanoc3::Filter.register "::Nutils::Filters::YuiCompressor", :yuicompressor
  end
end