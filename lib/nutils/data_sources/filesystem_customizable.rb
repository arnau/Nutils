module Nutils
  module DataSources

    # @author Arnau Siches
    #
    # @version 1.1.1
    #
    # The +filesystem_customizable+ data source allows an array for source 
    # directories and for layout directories.
    #
    # @example Config.yaml excerpt
    #   data_sources:
    #     -
    #       type: filesystem_customizable
    #       config:
    #         source_dir: ["src"]
    #         layout_dir: ["layouts", "other_layouts"]
    #
    # @see Nanoc3::DataSources::FilesystemUnified
    class FilesystemCustomizable < Nanoc3::DataSources::FilesystemUnified
      identifier :filesystem_customizable

      def setup
        # Create directories
        (@sources + @layouts).each { |dir| FileUtils.mkdir_p dir }
      end
      def items
        @sources.map do |dir|
          load_objects(dir, 'item', Nanoc3::Item)
        end.flatten
      end
      def layouts
        @layouts.map do |dir|
          load_objects(dir, 'layout', Nanoc3::Layout)
        end.flatten
      end

      def up
        @sources = config[:source_dir] || ['content']
        @layouts = config[:layout_dir] || ['layouts']
        @dtstart = Time.now
      end
      def down
        @dtend = Time.now
        puts "Data Loaded in #{format('%.2f', @dtend - @dtstart)}s."
      end


    end
  end
end