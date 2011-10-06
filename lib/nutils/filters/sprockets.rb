module Nutils
  module Filters
    # @author Arnau Siches
    #
    # @version 3.0.0
    #
    # @note Requires «sprockets»
    class SprocketWheel < Nanoc3::Filter
      identifier :sprockets
      type :text
      # Concatenate the Javascript, CoffeeScript or Sass content through [Sprockets](http://getsprockets.org).
      # This method takes no options.
      #
      # @param [String] content The content to filter.
      #
      # @return [String] The filtered content.
      def run(content, params={})
        require 'sprockets'
        raise "Sprockets should be 2.0.0 or higher" if Gem.loaded_specs['sprockets'].version < Gem::Version.create('2.0')
        
        filename  = Pathname.new(@item[:content_filename])
        
        # Create a temp file with the content received to give the desired
        # content to Sprockets on the same context.
        tmp_filename = filename.dirname + ('tmp_' + filename.basename.to_s)
        tmp_filename.open('w') { |io| io.puts content }
        
        load_path = params[:load_path] || []
        load_path << tmp_filename.dirname.realpath
        
        env = ::Sprockets::Environment.new(tmp_filename.dirname.realpath)
        
        # Assign load paths to Sprockets
        load_path.each do |path|
          env.append_path(File.expand_path(path))
        end
        
        # Get the Sprockets BundledAsset object for the content
        main_asset = env.find_asset(tmp_filename.realpath)
        
        # Select just the possible items that can be dependencies
        possible_items = @items.reject { |i| i[:content_filename].nil? }.select do |i|
          load_path.find { |p| Pathname.new(p).realpath.to_s == Pathname.new(i[:content_filename]).dirname.realpath.to_s }
        end
        
        # Get Nanoc::Item equivalent for each dependence managed by Sprockets
        dependencies = main_asset.dependencies.inject([]) do |dep, asset|
          item = possible_items.find { |i| asset.pathname == Pathname.new(i[:content_filename]).realpath }
          dep << item unless item.nil?
          dep
        end
        # Register Nanoc dependencies
        depend_on(dependencies) unless dependencies.nil?
        
        # Output compiled asset
        main_asset.to_s
      ensure
        tmp_filename.delete if tmp_filename.exist?
      end
    end
  end
end