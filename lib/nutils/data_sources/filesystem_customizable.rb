module Nanoc3::DataSources
  class FilesystemCustomizable < Nanoc3::DataSources::FilesystemUnified
    identifier :filesystem_customizable

    def setup
      # Create directories
      (config[:source_dir] + config[:layout_dir]).each { |dir| FileUtils.mkdir_p(dir) }
    end
    def items
      config[:source_dir].map do |dir|
        load_objects(dir, 'item', Nanoc3::Item)
      end.flatten
    end
    def layouts
      config[:layout_dir].map do |dir|
        load_objects(dir, 'layout', Nanoc3::Layout)
      end.flatten
    end
  end
end