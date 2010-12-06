module Nutils
  module Filters
    class SvgToPng < Nanoc3::Filter
      
      identifier :svg_to_png
      type :text => :binary
      
      def initialize(hash = {})
        require "rjb"
        require "tempfile"

        Rjb::load(classpath = '.', [ '-Djava.awt.headless=true', '-Dapple.awt.graphics.UseQuartz=false' ])
        @fileOutputStream = Rjb::import("java.io.FileOutputStream")
        @pngTranscoder = Rjb::import("org.apache.batik.transcoder.image.PNGTranscoder")
        @transcoderInput = Rjb::import("org.apache.batik.transcoder.TranscoderInput")
        @transcoderOutput = Rjb::import("org.apache.batik.transcoder.TranscoderOutput")
        @float = Rjb::import("java.lang.Float")
        @integer = Rjb::import("java.lang.Integer")
        @color = Rjb::import("java.awt.Color")
        @@_initialized = true
        super
      end

      # Converts an hexadecimal number with the format +#FC0+ or +#FFCC00+ to its integer representation.
      # 
      # @param [String] input The hexadecimal number.
      # 
      # @return [Integer] The corresponding integer.
      def hex2int(input)
        hexnum = input.delete("#")
        raise ArgumentError, "Got #{input}. Hexadecimal number must have the form #FC0 or #FFCC00." unless (hexnum.length == 3 or hexnum.length == 6)
        (hexnum.length == 3) ? hexnum.map { |i| i + i }.to_s.hex : hexnum.hex
      end

      # Runs the content through [Batik](http://xmlgraphics.apache.org/batik/).
      #
      # @param [String] content The content to filter.
      #
      # @option params [String] :background_color (nil) The background color with the 
      #   form +#FFCC00+ or +FC0+ of the result. Mask for the 
      #   +KEY_BACKGROUND_COLOR+ key.
      #
      # @option params [Integer] :dpi (72) This parameter lets you use the pixel
      #   to millimeter conversion factor.
      #   This factor is used to determine how units are converted into pixels. 
      #   Mask for the +KEY_PIXEL_TO_MM+ key.
      #
      # @option params [Integer] :heigth (nil) The height of the result. Mask for the
      #   +KEY_HEIGHT+ key.
      #
      # @option params [Integer] :width (nil) The width of the result. Mask for the
      #   +KEY_WIDTH+ key.
      #
      # @return [String] The filtered content.
      def run(content, params = {})
        t = @pngTranscoder.new

        opts = {
          :background_color => nil,
          :dpi => 72,
          :height => nil,
          :width => nil,
        }.merge(params)

        t.addTranscodingHint(@pngTranscoder.KEY_WIDTH, @float.new(opts[:width])) if opts[:width]
        t.addTranscodingHint(@pngTranscoder.KEY_HEIGHT, @float.new(opts[:height])) if opts[:height]
        t.addTranscodingHint(@pngTranscoder.KEY_PIXEL_TO_MM, @float.new(254 / opts[:dpi])) if opts[:dpi]
        t.addTranscodingHint(@pngTranscoder.KEY_BACKGROUND_COLOR, @color.new(hex2int(opts[:background_color]))) if opts[:background_color]
        # t.addTranscodingHint(@pngTranscoder.KEY_BACKGROUND_COLOR, @color.decode('#FC0'))

        tempfile = Tempfile.new(filename.gsub(/[^a-zA-Z0-9]/, '-'), ".")
        temppath = tempfile.path
        tempfile.puts content
        tempfile.close

        uri = "file:" + File.expand_path(temppath)

        input = @transcoderInput.new(uri)
        ostream = @fileOutputStream.new(output_filename)
        output = @transcoderOutput.new(ostream)
        t.transcode(input, output)

        ostream.flush()
        ostream.close()

      end

    end
  end
end