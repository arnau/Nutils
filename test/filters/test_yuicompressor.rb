# encoding: utf-8

class Nutils::Filters::YuiCompressorTest < MiniTest::Unit::TestCase

  include Nutils::TestHelpers

  def test_filter_with_css
    if_have 'yui/compressor' do
      filter = Nutils::Filters::YuiCompressor.new

      raw_content = <<-END_CSS
        div.warning {
          display: none;
        }
        div.error {
          background: red;
          color: white;
        }
        @media screen and (max-device-width: 640px) {
          body { font-size: 90%; }
        }
      END_CSS

      expected_content = %q(div.warning{display:none}div.error{background:red;color:white}@media screen and (max-device-width:640px){body{font-size:90%}})

      assert_equal(expected_content, filter.run(raw_content, :type => :css))
    end
  end

  def test_filter_with_js
    if_have 'yui/compressor' do
      filter = Nutils::Filters::YuiCompressor.new

      raw_content = <<-END_JS
        // here's a comment
        var Foo = { "a": 1 };
        Foo["bar"] = (function(baz) {
          /* here's a
             multiline comment */
          if (false) {
            doSomething();
          } else {
            for (var index = 0; index < baz.length; index++) {
              doSomething(baz[index]);
            }
          }
        })("hello");
      END_JS

      expected_content = %q(var Foo={a:1};Foo.bar=(function(baz){if(false){doSomething()}else{for(var index=0;index<baz.length;index++){doSomething(baz[index])}}})("hello");)

      assert_equal(expected_content, filter.run(raw_content, :type => :js))
    end
  end
end