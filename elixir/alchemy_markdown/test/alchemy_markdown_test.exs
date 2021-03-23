defmodule AlchemyMarkdownTest do
  use ExUnit.Case
  doctest AlchemyMarkdown

  test "italicizes" do
    input = "something *important*"
    expected = "something <em>important</em>"
    assert AlchemyMarkdown.to_html(input) =~ expected
  end

  test "expands big tags" do
    input = "Some ++big++ words!"
    expected = "<big>big</big>"
    assert AlchemyMarkdown.to_html(input) =~ expected
  end

  test "expands small tags" do
    input = "Some --small-- words!"
    expected = "<small>small</small>"
    assert AlchemyMarkdown.to_html(input) =~ expected
  end
end
