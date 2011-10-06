module Nutils
  module Filters

    # @author Arnau Siches
    #
    # @version 1.2.0
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
      # @option params [Symbol] :type The type of code to compress. Should be
      #   `:css` or `:js`.
      # 
      # @return [String] The filtered content.
      def run(content, params={})
        require "yui/compressor"
        if (params[:type] == :css)
          compressor = ::YUI::CssCompressor.new
        elsif (params[:type] == :js)
          # It fallbacks to `:type => :js` because backwards compatibility w/
          # prior versions of the filter.
          compressor = ::YUI::JavaScriptCompressor.new
        else
          raise "You should define a params[:type] either :js or :css"
        end

        compressor.compress(content)
      end
      
    end
  end
end