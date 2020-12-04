defmodule Day3 do
  def part1 do
    File.read!("inputs/day3.txt")
    |> String.split("\n", trim: true)
    |> down(0, {3, 1}, [])
    |> Enum.filter(&(&1 === "#"))
    |> length()
  end

  def part2 do
    [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]
    |> Enum.map(&calc_slope/1)
    |> Enum.reduce(fn x, acc ->
      x * acc
    end)
  end

  def calc_slope({right, down}) do
    File.read!("inputs/day3.txt")
    |> String.split("\n", trim: true)
    |> down(0, {right, down}, [])
    |> Enum.filter(&(&1 === "#"))
    |> length()
  end

  def down([], _, _, squares) do
    squares
  end

  def down([last], position, {_, 2}, squares) do
    char = Stream.cycle(String.codepoints(last)) |> Enum.at(position)
    squares ++ [char]
  end

  def down([head | tail], position, {right, down}, squares) do
    char = Stream.cycle(String.codepoints(head)) |> Enum.at(position)
    squares = squares ++ [char]

    case down do
      1 -> down(tail, position + right, {right, down}, squares)
      2 -> down(tl(tail), position + right, {right, down}, squares)
    end
  end
end
