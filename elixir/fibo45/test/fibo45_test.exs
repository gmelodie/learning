defmodule Fibo45Test do
  use ExUnit.Case
  doctest Fibo45

  test "returns first fibo numbers" do
    assert Fibo45.fibo(1) == 1
    assert Fibo45.fibo(2) == 1
  end

  test "returns invalid index" do
    assert_raise ArgumentError, "Invalid stop index. Needs to be higher than 0", fn ->
      Fibo45.fibo(0)
    end
  end

  test "gets 45 under 10s" do
    start = Time.utc_now()
    Fibo45.find()
    stop = Time.utc_now()
    runtime = Time.diff(stop, start, :microsecond)
    assert runtime <= 10000000
  end
end
