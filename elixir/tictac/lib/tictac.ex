defmodule Tictac do
  @players {:x, :o}

  def start do
    play(new_board())
  end

  def check_cols(board, row) do
    row = for c <- 1..3, do: Map.get(board, %Square{row: row, col: c})
    Enum.all?(row, fn x -> x == :x end) or Enum.all?(row, fn x -> x == :o end)
  end

  def check_rows(board, col) do
    col = for r <- 1..3, do: Map.get(board, %Square{row: r, col: col})
    Enum.all?(col, fn x -> x == :x end) or Enum.all?(col, fn x -> x == :o end)
  end

  def check_main_diag(board) do
    diag = for l <- 1..3, do: Map.get(board, %Square{row: l, col: l})
    Enum.all?(diag, fn x -> x == :x end) or Enum.all?(diag, fn x -> x == :o end)
  end

  def check_sec_diag(board) do
    diag = for l <- 1..3, do: Map.get(board, %Square{row: l, col: 4 -l})
    Enum.all?(diag, fn x -> x == :x end) or Enum.all?(diag, fn x -> x == :o end)
  end

  def game_over?(board) do
    cols = for r <- 1..3, do: check_cols(board, r)
    rows = for c <- 1..3, do: check_rows(board, c)
    Enum.any?(cols, fn x -> x == true end) or Enum.any?(rows, fn x -> x == true end)
    or check_main_diag(board)
    or check_sec_diag(board)
  end

  def play(board) do play(:x, board) end
  def play(player, board) do
    square = get_player_input(player)
    board = Map.put(board, square, player)
    IO.inspect(board)
    if game_over?(board) do
      IO.puts("Game Over!\n")
      exit()
    end
    if player == :x do
      play(:o, board)
    else
      play(:x, board)
    end
  end

  def get_player_input(player) do
    raw_input =
      if player == :x do
        IO.gets("Row and col for player X: ")
      else
        IO.gets("Row and col for player O: ")
      end
    [row, col] = String.split(raw_input, ~r{\s*,\s*|\n}, trim: true)
                 |> Enum.map(fn x -> String.to_integer(x) end)

    %Square{row: row, col: col}
  end

  def new_board do
    for s <- squares(), into: %{}, do: {s, :empty}
  end

  def squares do
    for c <- 1..3, r <- 1..3, into: MapSet.new(), do: %Square{row: r, col: c}
  end
end
