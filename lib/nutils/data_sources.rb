# encoding: utf-8
module Nutils
  module DataSources
    autoload "FilesystemCustomizable", "nutils/data_sources/filesystem_customizable"

    ::Nanoc::DataSource.register "::Nutils::DataSources::FilesystemCustomizable",  :filesystem_customizable
  end
end
