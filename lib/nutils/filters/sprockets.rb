module Nutils
  module Filters

    # @author Arnau Siches
    #
    # @version 1.0.0
    #
    # @note Requires «sprockets»
    class SprocketWheel < Nanoc3::Filter

      identifier :sprockets
      type :text

      # Concatenate the Javascript content through [Sprockets](http://getsprockets.org).
      # This method takes no options.
      #
      # @param [String] content The content to filter.
      #
      # @return [String] The filtered content.
      def run(content, params={})
        require "sprockets"
        require "tempfile"

        tmp_file = Tempfile.new("sprockets.tmp", File.dirname(@item[:filename]))

        tmp_file.puts content
        tmp_file.open
        
        source_files = tmp_file.path
        load_path = params[:load_path] || File.dirname(@item[:filename])

        params.merge!({
          :load_path => load_path,
          :source_files => [source_files]
        })

        secretary = ::Sprockets::Secretary.new(params)
        secretary.install_assets if params[:asset_root]
        secretary.concatenation

      end
    end
  end
end