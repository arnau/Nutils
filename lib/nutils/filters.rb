module Nutils
  module Filters
    autoload 'Beautify', 'nutils/filters/beautify'
    autoload 'Crop', 'nutils/filters/crop'
    autoload 'SprocketWheel', 'nutils/filters/sprockets'
    autoload 'SvgToPng', 'nutils/filters/svg2png'
    autoload 'YuiCompressor', 'nutils/filters/yuicompressor'

    ::Nanoc::Filter.register '::Nutils::Filters::Beautify', :beautify
    ::Nanoc::Filter.register '::Nutils::Filters::Crop', :crop
    ::Nanoc::Filter.register '::Nutils::Filters::SprocketWheel', :sprockets
    ::Nanoc::Filter.register '::Nutils::Filters::SvgToPng', :svg_to_png
    ::Nanoc::Filter.register '::Nutils::Filters::YuiCompressor', :yuicompressor
  end
end
