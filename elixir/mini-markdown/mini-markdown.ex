require Regex
require String

defmodule MiniMarkdown do
  def to_html(text) do
    html_text = "<html>\n#{text}\n</html>"
      |> bold # bold has to come before italics
      |> italics
      |> header1
      |> list
  end

  def italics(text) do
    Regex.replace(~r{\*(.*)\*}, text, "<em>\\1</em>")
  end

  def bold(text) do
    Regex.replace(~r{\*\*(.*)\*\*}, text, "<strong>\\1</strong>")
  end

  def header1(text) do
    Regex.replace(~r{#\s(.*)\n}, text, "<h1>\\1</h1>")
  end

  def list(text) do
    # replace marking (before and after)
    text = Regex.replace(~r{\s*\d+\.\s*(.*)}, text,"<ol>\n\t<li>\\1</li>\n</ol>")

    # remove unecessary opening and closing <ol>s
    Regex.replace(~r{\n*</ol>\n*<ol>}, text, "")
  end
end
