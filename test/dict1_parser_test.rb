require 'minitest/autorun'

class Dict1ParserTest < MiniTest::Unit::TestCase
  def setup
    @test_data = `-ade,"act, product, sweet drink","blockade, lemonade"`
    @parser = Dict1Parser.new

    @expected = '{"name":["-ade"],"meaning":["act","product","sweet drink"],\
"examples":["blockade", "lemonade"]}'
  end

  def teardown
    # Do nothing
  end

  def test
    assert_equal @expected, @parser.parse_string @test_data, false
  end
end