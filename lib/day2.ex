defmodule Day2 do
  def part1 do
    File.read!("inputs/day2.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.map(&valid?/1)
    |> Enum.filter(&(&1 === true))
    |> length()
  end

  def part2 do
    File.read!("inputs/day2.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.map(&valid_part2?/1)
    |> Enum.filter(&(&1 === true))
    |> length()
  end

  def parse_line(line) do
    [range, char, password] =
      line
      |> String.split(" ")

    range = range |> String.split("-") |> Enum.map(&String.to_integer/1)
    char = char |> String.replace(":", "")
    {char, range, password}
  end

  def valid?({char, [min, max], password}) do
    count =
      password
      |> String.codepoints()
      |> Enum.filter(&(&1 === char))
      |> length

    count >= min and count <= max
  end

  def valid_part2?({char, [pos1, pos2], password}) do
    char1 =
      password
      |> String.codepoints()
      |> Enum.at(pos1 - 1)

    char2 =
      password
      |> String.codepoints()
      |> Enum.at(pos2 - 1)

    [char1, char2] |> Enum.filter(&(&1 === char)) |> length() === 1
  end
end
