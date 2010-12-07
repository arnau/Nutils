module Nutils
  module DataSources
    autoload "FilesystemCustomizable", "nutils/data_sources/filesystem_customizable"

    ::Nanoc3::DataSource.register "::Nutils::DataSources::FilesystemCustomizable",  :filesystem_customizable
  end
end