defmodule Gcj.PancakeFlipper do

  ## read in a file and solve for each row
  def read_file_and_solve(filename) do
    File.read!(filename)
    |> String.split("\n")
    |> List.delete_at(-1)
    |> Enum.with_index(1)
    |> Enum.each( fn(row) ->
      [pancakes, flipper_size] = elem(row, 0) |> String.split(" ")
      result = solve(pancakes, String.to_integer(flipper_size))
      IO.puts "Case ##{elem(row, 1)}: " <> result
    end)
  end

  ## convert the string of pancakes to a list and solve
  def solve(pancakes, flipper_size) do
    {pancakes, flips} = pancakes
    |> String.split("")
    |> List.delete_at(-1)
    |> walk(flipper_size)

    case Enum.all?(pancakes, &(&1 == "+")) do
      true -> Integer.to_string flips
      false -> "IMPOSSIBLE"
    end
  end

  ## walk up the row, flip if the pancake is "-"
  def walk(pancakes, flipper_size, flips \\ 0, position \\ 0) do
    case position + flipper_size < length(pancakes) + 1 do
      false ->
        { pancakes, flips }
      true ->
        case Enum.at(pancakes, position) do
          "-" ->
            walk(flip(pancakes, position, flipper_size), flipper_size, flips + 1, position + 1)
          _ ->
            walk(pancakes, flipper_size, flips, position + 1)
        end
    end
  end

  ## flip the pancakes from the start position to the end of the size of the flipper
  def flip(pancakes, _position, 0), do: pancakes
  def flip(pancakes, position, flipper_size) do
    pancakes
    |> List.replace_at(position, flip_pancake(Enum.at(pancakes, position)))
    |> flip(position + 1, flipper_size - 1)
  end

  def flip_pancake(pancake) do
    case pancake do
      "+" -> "-"
      "-" -> "+"
      _ -> pancake
    end
  end

end

ExUnit.start(colors: [enabled: true], exclude: [skip: true])
defmodule Gcj.PancakeFlipperTest do
  use ExUnit.Case

  # @tag :skip
  test "examples given in description work as expected" do
    assert Gcj.PancakeFlipper.solve("---+-++-", 3) == "3"
    assert Gcj.PancakeFlipper.solve("++++", 4) == "0"
    assert Gcj.PancakeFlipper.solve("-+-+-", 4) == "IMPOSSIBLE"
  end

  # @tag :skip
  test "walk up the list" do
    assert Gcj.PancakeFlipper.walk(["-", "-", "-", "+", "-", "+", "+", "-"], 3)
      == {["+", "+", "+", "+", "+", "+", "+", "+"], 3}

    assert Gcj.PancakeFlipper.walk(["-", "+", "-", "+", "-"], 4)
        == {["+", "+", "-", "+", "+"], 2}
  end

  test "flipping pancakes works" do
    assert Gcj.PancakeFlipper.flip(["-","-","-"],0, 3) == ["+","+","+"]
    assert Gcj.PancakeFlipper.flip(["-","-","-","-","-","-"],3, 2) == ["-","-","-","+","+", "-"]
  end

  test "flipping a single pancake works" do
    assert Gcj.PancakeFlipper.flip_pancake("+") == "-"
    assert Gcj.PancakeFlipper.flip_pancake("-") == "+"
  end
end
