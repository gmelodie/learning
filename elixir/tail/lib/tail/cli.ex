defmodule Tail.CLI do
  def main(args) do
    {opts, filename, _invalid} = OptionParser.parse(
      args,
      strict: [lines: :integer],
      aliases: [n: :lines]
    )
    Tail.start(opts, filename)
  end
end
