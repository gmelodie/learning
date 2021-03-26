defmodule WordCount do
  def start(parsed, args, invalid) do
    IO.inspect({parsed, args, invalid})
    IO.puts(parsed[:words])

    [filename | _] = args
    content = File.read!(filename)
    if parsed[:words] do
      count_words(content)
    end
  end

  def count_words(content) do
    content
      |> String.split(~r{[\s\,\.]+}, trim: true)
      |> Enum.count()
  end
end
