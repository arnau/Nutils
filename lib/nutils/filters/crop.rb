module Nutils
  module Filters

    # @author Arnau Siches
    #
    # @version 0.1.1
    #
    # @note Requires «RMagick»
    class Crop < Nanoc3::Filter
      
      identifier :crop
      type :binary

      # Runs the content through {http://www.simplesystems.org/RMagick/doc/image1.html#crop RMagick#crop}.
      #
      # @param [String] filename The filename of the temporal file to filter.
      #
      # @option params [Integer] :x The x-offset of the rectangle relative 
      #   to the upper-left corner of the image.
      # 
      # @option params [Integer] :y The y-offset of the rectangle relative 
      #   to the upper-left corner of the image.
      # 
      # @option params [String] :width The width of the rectangle. This param can
      #   handle string-expressions like +"image.columns - 1"+ where +image.columns+
      #   is the width of the input image.
      # 
      # @option params [String] :height The height of the rectangle. This param can
      #   handle string-expressions like +"image.rows - 1"+ where +image.rows+
      #   is the height of the input image.
      # 
      # @return [File] The filtered content.
      def run(filename, opts = {})
        require 'RMagick'

        raise ArgumentError, "x, y, width and height are required parameters." unless opts[:x] and opts[:y] and opts[:width] and opts[:height]

        image = Magick::ImageList.new filename

        width = eval(opts[:width].to_s)
        height = eval(opts[:height].to_s)

        image.crop(opts[:x], opts[:y], width, height).write output_filename

      rescue Exception => e
        raise ArgumentError, "#{e}\nSome parameters cannot be promoted to Integer."
      end

    end
  end
end