defmodule WordCountTest do
  use ExUnit.Case
  doctest WordCount

  test "count words" do
    input = """
    Hello, this file contains 6 words
    """
    expected = 6
    assert WordCount.count_words(input) == expected
  end
end
