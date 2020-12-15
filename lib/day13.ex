defmodule Day13 do
  def part1 do
    [time, buses] =
      File.read!("inputs/day13.txt")
      |> String.split("\n", trim: true)

    time = String.to_integer(time)

    buses =
      buses
      |> String.split(",")
      |> Enum.reject(&(&1 == "x"))
      |> Enum.map(&String.to_integer/1)

    get_bus_time(buses, time, [])
  end

  def get_bus_time([], _, times), do: times

  def get_bus_time([bus | tail], time, times) do
    result = :math.ceil(time / bus) * bus - time
    get_bus_time(tail, time, times ++ [{result, bus}])
  end
end
