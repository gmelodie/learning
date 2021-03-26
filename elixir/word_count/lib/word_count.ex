defmodule WordCount do
  def start(parsed, args, invalid) do
    IO.inspect({parsed, args, invalid})
    IO.puts(parsed[:words])

    [filename | _] = args
    content = File.read!(filename)
    if parsed[:chars] do
      count_chars(content)
    end
    if parsed[:words] do
      count_words(content)
    end
    if parsed[:lines] do
      count_lines(content)
    end
  end

  def count_chars(content) do
    content
    |> String.replace(~r{\n}, "", trim: true)
    |> String.length
  end

  def count_words(content) do
    content
    |> String.split(~r{[\s\,\.]+}, trim: true)
    |> Enum.count()
  end

  def count_lines(content) do
    content
    |> String.split(~r{\n|\r|\r\n}, trim: true)
    |> Enum.count()
  end
end
