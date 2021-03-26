defmodule WordCountTest do
  use ExUnit.Case
  doctest WordCount

  test "counts chars" do
    input = """
    Hello, this file contains 34 chars
    """
    expected = 34
    assert WordCount.count_chars(input) == expected
  end

  test "counts words" do
    input = """
    Hello, this file contains 6 words
    """
    expected = 6
    assert WordCount.count_words(input) == expected
  end

  test "counts lines" do
    input = """
    Hello, this file contains
    3
    lines\n
    """
    expected = 3
    assert WordCount.count_lines(input) == expected
  end
end
