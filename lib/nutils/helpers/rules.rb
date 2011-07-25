module Nutils
  module Helpers

    # @author Arnau Siches
    #
    # @version 0.1.0
    # 
    # Provides some helper functions to process Rules.
    module Rules
      
      # Compiles the content as a set of Nanoc rules. Tries to use the 
      # +rules_dir+ attribute from the Config.yaml.
      # If +rules_dir+ is not defined, it uses +"."+ as a base path.
      # 
      # @example Config.yaml excerpt
      # 
      #   rules_dir: ['lib/rules/**', 'lib/other_rules']
      #
      # @example Rules excerpt
      # 
      #   # Finds any foo.rule in all directories defined in the Config.yaml
      #   load_rules('foo.rule')
      # 
      # @param [String] filepath The file path to load.
      # 
      # @return [Proc]
      def load_rules(filepath)
        # Monkey-patch to obtain the site configuration since nanoc 3.2
        if Gem.loaded_specs["nanoc3"].version >= Gem::Version.create('3.1') and  Gem.loaded_specs["nanoc3"].version < Gem::Version.create('3.2')
          rules_dir = @site.config[:rules_dir] || ['.']
        elsif Gem.loaded_specs["nanoc3"].version >= Gem::Version.create('3.2')
          rules_dir = @rules_collection.instance_variable_get(:@compiler).instance_variable_get(:@site).config[:rules_dir] || ['.']
        else
          raise "The load_rules helper needs nanoc 3.1 or higher."
        end


        path = rules_dir.map do |dir|
          Dir[File.join(dir, filepath)].each { |filename| filename }
        end.flatten

        if path.length > 1
          puts "\e[1mwarning\e[0m Multiple matches for #{filepath}:",
               "  #{path.join("\n  ")}",
               "  \e[1mused\e[0m #{path[0]}"
        elsif path.length == 0
          raise Nutils::Errors::NoRulesFileFound.new(filepath)
        end

        instance_eval(File.read(path[0]), path[0])
      end

    end

  end
end
