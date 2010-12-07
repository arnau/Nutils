module Nutils
  module Filters

    # @author Arnau Siches
    # @author Choan Gálvez
    #
    # @version 0.5.0
    #
    # @note Requires htmlbeautifer
    #
    # @todo Pass parameters to the HtmlBeautifer engine.
    class Beautify < Nanoc3::Filter

      identifier :beautify
      type :text

      # Runs the content through [htmlbeautifier](http://github.com/threedaymonk/htmlbeautifier/).
      # This method takes no options.
      #
      # @param [String] content The content to filter.
      #
      # @return [String] The retabed HTML.
      def run(content, params = {})
        require "htmlbeautifier/beautifier"
        buffer = ""
        ::HtmlBeautifier::Beautifier.new(buffer).scan(content)
        buffer
      end

    end

  end
end