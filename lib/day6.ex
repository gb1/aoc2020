defmodule Day6 do
  def part1 do
    File.read!("inputs/day6.txt")
    |> String.split("\n\n", trim: true)
    |> Enum.map(&String.replace(&1, "\n", ""))
    |> Enum.map(&String.codepoints/1)
    |> Enum.map(fn group ->
      group
      |> Enum.sort()
      |> Enum.dedup()
      |> length
    end)
    |> Enum.sum()
  end

  def part2 do
    File.read!("inputs/day6.txt")
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn group ->
      String.split(group, "\n", trim: true)
      |> Enum.map(&Enum.into(String.codepoints(&1), MapSet.new()))
    end)
    |> Enum.map(fn sets ->
      Enum.reduce(sets, hd(sets), fn x, acc ->
        MapSet.intersection(acc, x)
      end)
    end)
    |> Enum.map(&MapSet.size/1)
    |> Enum.sum()
  end
end
