module Nutils
  module Filters

    # @author Arnau Siches
    #
    # @version 1.0.0
    #
    # @note Requires «yui-compressor»
    class YuiCompressor < Nanoc3::Filter
      
      identifier :yuicompressor
      type :text

      # Compress the content with [YUI Compressor](http://developer.yahoo.com/yui/compressor/).
      # This method takes no options.
      #
      # @param [String] content The content to filter.
      #
      # @return [String] The filtered content.
      def run(content, params={})
        require "yui/compressor"
        compressor = ::YUI::JavaScriptCompressor.new(params)
        compressor.compress(content)
      end
      
    end
  end
end