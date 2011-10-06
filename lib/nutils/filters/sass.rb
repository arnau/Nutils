# encoding: utf-8
require 'sass'
module Nutils
  module SassImporters
    ##
    # Essentially the {Sass::Importers::Filesystem} but registering each import
    # file path and using item identifiers as a value for the @import directive.
    # @author Arnau Siches
    #
    # @version 1.0.0
    class NanocItems < ::Sass::Importers::Filesystem
      private
      
      def _find(dir, name, options)
        filter = ::Nanoc3::Filters::Sass.current
        item = filter.instance_variable_get(:@items).find { |i| name == i.identifier }
        if name.start_with? '/' and !item.nil?
          filter.depend_on([ item ]) unless item.nil?
          
          any_uncompiled_rep = item.reps.find { |r| !r.compiled? }
          raise ::Nanoc3::Errors::UnmetDependency.new(any_uncompiled_rep) if any_uncompiled_rep
          content = item.compiled_content
          options[:syntax] = 'sass'
          options[:filename] = ::Pathname.new(item[:content_filename]).realpath
        else
          full_filename, syntax = find_real_file(dir, name)
          return unless full_filename && File.readable?(full_filename)
          
          item = filter.imported_filename_to_item(full_filename)
          filter.depend_on([ item ]) unless item.nil?
          
          content = File.read(full_filename)
          options[:syntax] = syntax
          options[:filename] = full_filename
        end
        options[:importer] = self
        ::Sass::Engine.new(content, options)
      end
    end
  end
end