defmodule Gcj.TidyNumbers do

  def is_tidy?(number) do
    list = number
    |> String.split("")
    |> List.delete_at(-1)

    list == Enum.sort(list)
  end

  def get_next_tidy(number) do

  end

end

ExUnit.start(colors: [enabled: true], exclude: [skip: true])
defmodule Gcj.TidyNumbersTest do
  use ExUnit.Case


  test "is number a tidy number?" do
    assert Gcj.TidyNumbers.is_tidy?("132") == false
    assert Gcj.TidyNumbers.is_tidy?("1000") == false
    assert Gcj.TidyNumbers.is_tidy?("7") == true
  end

  test "get the next tidy number for the examples" do
    assert Gcj.TidyNumbers.get_next_tidy("132") == "129"
  end

end
