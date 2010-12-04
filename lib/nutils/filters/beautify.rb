module Nutils
  module Filters

    class Beautify < Nanoc3::Filter

      require "htmlbeautifier/beautifier"

      identifier :beautify
      type :text

      # Runs the content through [htmlbeautifier](http://github.com/threedaymonk/htmlbeautifier/).
      #
      # @param [String] string The content to filter.
      #
      # @return [String] The retabed HTML.
      def run(content, params = {})
        buffer = ""
        ::HtmlBeautifier::Beautifier.new(buffer).scan(content)
        buffer
      end

    end

  end
end