# encoding: utf-8

class Nutils::Filters::BeautifyTest < MiniTest::Unit::TestCase

  include Nutils::TestHelpers

  def test_filter
    if_have 'htmlbeautifier/beautifier' do
      # skip "Not yet implemented"

      # Create filter
      filter = Nutils::Filters::Beautify.new

      # Set content
      raw_content = %q(
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
<script src="/foo.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="/foo.css" />

<title>Beautify test</title>
  </head>
<body>
<div id="header">
<h1>
Heading 1
</h1>
<p>Lorem ipsum</p>
</div>
<div id="content">
<p>Lorem Ipsum</p>
<p>Lorem Ipsum</p>
<p>Lorem Ipsum</p>
</div>
</body>
</html>)
      expected_content = %q(<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <script src="/foo.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="/foo.css" />
    <title>Beautify test</title>
  </head>
  <body>
    <div id="header">
      <h1>
        Heading 1
      </h1>
      <p>Lorem ipsum</p>
    </div>
    <div id="content">
      <p>Lorem Ipsum</p>
      <p>Lorem Ipsum</p>
      <p>Lorem Ipsum</p>
    </div>
  </body>
</html>)

      assert_equal(expected_content, filter.run(raw_content))

    end
  end
end