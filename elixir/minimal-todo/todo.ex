require String
require Integer

defmodule TodoApp do
  # TODO: open empty todo list instead of loading from file

  def start do
    IO.gets("File: ")
    |> String.trim
    |> load_todo_list()
    |> menu()
  end

  def save_todo_list({head, todo_list}, filename) do
    # TODO: if list was loaded from file, save to that same file by default
    todo_list = [head | todo_list] # add header to be saved
    content = Enum.reduce(todo_list, "", fn todo, acc ->
      acc <> Enum.join(todo, ", ") <> "\n"
    end)
    File.write(filename, content)
    {head, todo_list}
  end

  def load_todo_list(filename) do
    {:ok, content} = File.read(filename)
    parse_csv(content)
  end

  def parse_csv(content) do
    [head | todo_list] = content
                     |> String.split(~r{\n|\r|\r\n}, trim: true)
                     |> Enum.map(fn line -> String.split(line, ~r{\s*,\s*}) end)
    {head, todo_list}
  end

  def print_todo_list({head, todo_list}) do
    IO.puts("\n\n")
    Enum.with_index(todo_list)
    |> Enum.each(fn {todo, index} ->
      # print index before todo
      str_index = Integer.to_string(index)
      IO.write(str_index <> " - ")
      todo
      |> Enum.at(0) # get the first field ("item")
      |> String.capitalize
      |> IO.puts()
    end)
    IO.puts("\n\n")

    {head, todo_list}
  end

  def delete_todo({head, todo_list}, idx) do
    # TODO: check if index is valid
    todo_list = List.delete_at(todo_list, idx)
    {head, todo_list}
  end

  def add_todo({head, todo_list}, new_todo) do
    # TODO: check if number of fields is valid
    new_todo = String.split(new_todo, ~r{\s*,\s*}, trim: true)
    todo_list = todo_list ++ [new_todo]
    {head, todo_list}
  end


  def menu(state) do
    menu_txt = """
    1. Print current list
    2. Add todo
    3. Delete todo
    4. Load new todo list
    5. Save current list to file
    6. Quit
    """
    {choice, _} = IO.gets(menu_txt) |> Integer.parse

    state = case choice do
      1 ->
        print_todo_list(state)
      2 ->
        new_todo = IO.gets("New todo: ") |> String.trim
        add_todo(state, new_todo)
      3 ->
        {todo_idx, _} = IO.gets("Todo number: ") |> String.trim |> Integer.parse
        delete_todo(state, todo_idx)
      4 ->
        filename = IO.gets("File: ") |> String.trim
        load_todo_list(filename)
      5 ->
        filename = IO.gets("File: ") |> String.trim
        save_todo_list(state, filename)
      6 -> exit("Exiting...")
    end
    menu(state)
  end


end
