require Time

defmodule Fibo45 do
  @correct_45th_number 1134903170

  def fibo(stop_idx, curr_idx \\ 3, last_num \\ 1, second_to_last_num \\ 1)
  def fibo(stop_idx, curr_idx, last_num, _) when curr_idx == stop_idx + 1 do last_num end
  def fibo(stop_idx, _, _, _) when stop_idx == 1 do 1 end
  def fibo(stop_idx, _, _, _) when stop_idx == 2 do 1 end
  def fibo(stop_idx, _, _, _) when stop_idx < 1 do
    raise ArgumentError, message: "Invalid stop index. Needs to be higher than 0"
  end

  def fibo(stop_idx, curr_idx, last_num, second_to_last_num) do
    curr_num = last_num + second_to_last_num
    fibo(stop_idx, curr_idx+1, curr_num, last_num)
  end

  def find do
    fibo(45)
  end

  def time do
    start = Time.utc_now()

    ans = find()
    if ans != @correct_45th_number do
      IO.puts("Incorrect number! Expected #{} got #{}")
    end

    stop = Time.utc_now()
    runtime = Time.diff(stop, start, :microsecond)
    IO.puts("Number calculated in #{runtime} microseconds (1e-6s)")
  end
end
