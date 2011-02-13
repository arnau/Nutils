module Nutils
  module Errors
    
    # Error that is raised when no partial rules file can be found in any
    # directory provided.
    class NoRulesFileFound < ::Nanoc3::Errors::NoRulesFileFound

      # @param [String] filename The file name not found.
      def initialize(filename)
        super("No file found in any directory provided for “#{filename}”".make_compatible_with_env)
      end

    end
    
  end
end