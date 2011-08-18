# encoding: utf-8

class Nutils::Filters::CropTest < MiniTest::Unit::TestCase

  include Nutils::TestHelpers

  def test_filter
    if_have 'RMagick' do
      skip "Not yet implemented"
    end
  end
end