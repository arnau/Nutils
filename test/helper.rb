# encoding: utf-8

# This code is 100% from Nanoc Tests. Thanks Denis.

# Set up gem loading (necessary for cri dependency)
# require File.dirname(__FILE__) + '/gem_loader.rb'

# Load unit testing stuff
begin
  require 'minitest/unit'
  require 'minitest/spec'
  require 'minitest/mock'
  require 'mocha'

  require 'nanoc3'
  require 'nanoc3/cli'
  require 'nanoc3/tasks'

  require 'tempfile'
rescue => e
  $stderr.puts "To run the nanoc unit tests, you need minitest and mocha."
  raise e
end

# Load nutils
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + '/../lib'))
require 'nutils'

BASE = File.dirname(__FILE__)

# Load miscellaneous requirements
require 'stringio'

module Nutils::TestHelpers

  def if_have(*libs)
    libs.each do |lib|
      begin
        require lib
      rescue LoadError
        skip "requiring #{lib} failed"
        return
      end
    end

    yield
  end

  def if_implemented
    begin
      yield
    rescue NotImplementedError, NameError
      skip $!
      return
    end
  end

  def with_site(params={})
    # Build site name
    site_name = params[:name]
    if site_name.nil?
      @site_num ||= 0
      site_name = "site-#{@site_num}"
      @site_num += 1
    end

    # Build rules
    rules_content = <<EOS
compile '*' do
  {{compilation_rule_content}}
end

route '*' do
  if item.binary?
    item.identifier.chop + '.' + item[:extension]
  else
    item.identifier + 'index.html'
  end
end

layout '*', :erb
EOS
    rules_content.gsub!('{{compilation_rule_content}}', params[:compilation_rule_content] || '')

    # Create site
    unless File.directory?(site_name)
      FileUtils.mkdir_p(site_name)
      FileUtils.cd(site_name) do
        FileUtils.mkdir_p('content')
        FileUtils.mkdir_p('layouts')
        FileUtils.mkdir_p('lib')
        FileUtils.mkdir_p('output')

        if params[:has_layout]
          File.open('layouts/default.html', 'w') do |io|
            io.write('... <%= @yield %> ...')
          end
        end

        File.open('config.yaml', 'w') { |io| io.write('stuff: 12345') }
        File.open('Rules', 'w') { |io| io.write(rules_content) }
      end
    end

    # Yield site
    FileUtils.cd(site_name) do
      yield ::Nanoc3::Site.new('.')
    end
  end

  def setup
    # Check skipped
    if ENV['skip']
      if ENV['skip'].split(',').include?(self.class.to_s)
        skip 'manually skipped'
      end
    end

    # Clean up
    GC.start

    # Go quiet
    # unless ENV['QUIET'] == 'false'
    #   $stdout = StringIO.new
    #   $stderr = StringIO.new
    # end

    # Enter tmp
    FileUtils.mkdir_p('tmp')
    FileUtils.cd('tmp')
  end

  def teardown
    # Exit tmp
    FileUtils.cd('..')
    FileUtils.rm_rf('tmp')

    # Go unquiet
    unless ENV['QUIET'] == 'false'
      $stdout = STDOUT
      $stderr = STDERR
    end
  end

end
