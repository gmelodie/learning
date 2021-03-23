defmodule AlchemyMarkdownTest do
  use ExUnit.Case
  doctest AlchemyMarkdown

  test "italicizes" do
    input = "something *important*"
    expected = "something <em>important</em>"
    assert AlchemyMarkdown.to_html(input) =~ expected
  end
end
