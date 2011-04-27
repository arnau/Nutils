# encoding: utf-8

require 'sass'

module Nutils
  module Filters
    class Sass < Nanoc3::Filters::Sass
      FILES = []
      identifier :zass
      type :text

      # Runs the content through [Sass](http://sass-lang.com/).
      # Parameters passed to this filter will be passed on to Sass.
      #
      # @param [String] content The content to filter
      #
      # @return [String] The filtered content
      def run(content, params={})
        # Get options
        options = params.dup
        sass_filename = options[:filename] || (@item && @item[:content_filename])
        options[:filename] ||= sass_filename
        options[:filesystem_importer] ||= Nutils::Importers::Nanoc
        
        # Build engine
        engine = ::Sass::Engine.new(content, options)
        output = engine.render
        
        until Nutils::Filters::Sass::FILES.empty?
          filename = Nutils::Filters::Sass::FILES.pop
          notify(filename)
        end
        
        return output
      end

      def notify(filename)
        pathname = Pathname.new(filename)
        item = @items.find { |i| i[:content_filename] && Pathname.new(i[:content_filename]).realpath == pathname.realpath }
        
        unless item.nil?
          # Notify
          ::Nanoc3::NotificationCenter.post(:visit_started, item)
          ::Nanoc3::NotificationCenter.post(:visit_ended,   item)
          
          # Raise unmet dependency error if item is not yet compiled
          any_uncompiled_rep = item.reps.find { |r| !r.compiled? }
          raise ::Nanoc3::Errors::UnmetDependency.new(any_uncompiled_rep) if any_uncompiled_rep
        end
      end

    end
  end


  module Importers

    ##
    # Essentially the {Sass::Importers::Filesystem} but registering each import
    # file path.
    class Nanoc < ::Sass::Importers::Filesystem
      
      private
      
      def _find(dir, name, options)
        full_filename, syntax = find_real_file(dir, name)
        return unless full_filename && File.readable?(full_filename)
        
        Nutils::Filters::Sass::FILES << full_filename
        
        options[:syntax] = syntax
        options[:filename] = full_filename
        options[:importer] = self
        ::Sass::Engine.new(File.read(full_filename), options)
      end
    end
  end

end