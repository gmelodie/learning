defmodule Tail do
  def start(opts, filename) do
    content = File.read!(filename)
    |> String.split(~r{\n|\r|\r\n}, trim: true)

    if opts[:lines] do
      print_tail(content, opts[:lines])
    else
      print_tail(content)
    end
  end

  def print_tail(lines, n \\ 10) do
    lines
    |> Enum.take(-n)
    |> Enum.join("\n")
    |> IO.puts()
  end
end
