defmodule AlchemyMarkdown do
  def to_html(md_text) do
    Earmark.as_html!((md_text || ""), %Earmark.Options{smartypants: false})
      |> big
      |> small
  end

  def big(md_text) do
    Regex.replace(~r{\+\+(.*)\+\+}, md_text, "<big>\\1</big>")
  end

  def small(md_text) do
    Regex.replace(~r{\-\-(.*)\-\-}, md_text, "<small>\\1</small>")
  end
end
