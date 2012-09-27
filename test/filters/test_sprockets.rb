# encoding: utf-8

class Nutils::Filters::SprocketWheelTest < MiniTest::Unit::TestCase

  include Nutils::TestHelpers

  def test_filter
    if_have 'sprockets' do
      # Create filter
      path = File.expand_path(File.join BASE, 'fixtures', 'sprockets', 'in', 'main.js')
      foo_path = File.expand_path(File.join BASE, 'fixtures', 'sprockets', 'in', 'partials', 'foo.js')
      raw_content = File.read(path)
      items = [
        ::Nanoc::Item.new(raw_content, {:content_filename => path}, '/main/'),
        ::Nanoc::Item.new(File.read(foo_path), {:content_filename => foo_path}, '/partials/foo/'),
      ]
      params = { :item => items[0], :items => items }
      
      filter = Nutils::Filters::SprocketWheel.new(params)
      
      expected_content = <<-JS
var foo = true;
var boo = 'look me!';
var xoo = false;


var bar = true;



function main (argument) {
  // body...
};
JS
      assert_equal(expected_content, filter.run(raw_content, {
        :load_path => [File.expand_path(File.join BASE, 'fixtures', 'sprockets', 'in', 'partials')]
      }))
    end
  end

end

