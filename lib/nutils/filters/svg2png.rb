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

      # Converts an hexadecimal number with the format #FC0 or #FFCC00 to its integer representation.

      # @param [String] The Hexadecimal number.

      # @return [Integer].
      def hex2int(input)
        hexnum = input.delete("#")
        raise ArgumentError, "Got #{input}. Hexadecimal number must have the form #FC0 or #FFCC00." unless (hexnum.length == 3 or hexnum.length == 6)
        (hexnum.length == 3) ? hexnum.map { |i| i + i }.to_s.hex : hexnum.hex
      end

      def run(content, params = {})
        t = @pngTranscoder.new

        opts = {
          :width => nil,
          :height => nil,
          :background_color => nil,
          :dpi => 72,
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