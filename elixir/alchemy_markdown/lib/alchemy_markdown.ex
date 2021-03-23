defmodule AlchemyMarkdown do
  def to_html(md_text) do
    Earmark.as_html!((md_text || ""), %Earmark.Options{smartypants: false})
  end
end
