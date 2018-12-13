require "minitest/autorun"
require_relative 'challenge'

class TestChallenge < Minitest::Test

  def test_check_surrounding
    input = load_input('input_1.txt')
    bounds = Challenge.new(input).blob_bounds()
    expected = {top: 1, bottom: 7, left: 2, right: 6}
    assert_equal(expected, bounds)

    input = load_input('input_2.txt')
    bounds = Challenge.new(input).blob_bounds()
    expected = {top: 1, bottom: 7, left: 0, right: 8}
    assert_equal(expected, bounds)
  end

  def load_input(filename)
    open(filename).read.strip.split("\n")
  end
end