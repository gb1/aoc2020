defmodule Day5 do
  def part1 do
    rows = 0..127 |> Enum.into([])
    cols = 0..7 |> Enum.into([])

    File.read!("inputs/day5.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(fn pass ->
      seat(String.codepoints(pass), rows, cols)
    end)
    |> Enum.max()
  end

  def part2 do
    rows = 0..127 |> Enum.into([])
    cols = 0..7 |> Enum.into([])

    seats =
      File.read!("inputs/day5.txt")
      |> String.split("\n", trim: true)
      |> Enum.map(&seat(String.codepoints(&1), rows, cols))

    for r <- 1..126 do
      for c <- 0..7 do
        id = r * 8 + c

        if id not in seats do
          if (id + 1) in seats and (id - 1) in seats do
            IO.inspect(id)
          end
        end
      end
    end

    :ok
  end

  def seat([], rows, cols) do
    hd(rows) * 8 + hd(cols)
  end

  def seat(["F" | tail], rows, cols) do
    {front, _} = Enum.split(rows, div(length(rows), 2))
    seat(tail, front, cols)
  end

  def seat(["B" | tail], rows, cols) do
    {_, back} = Enum.split(rows, div(length(rows), 2))
    seat(tail, back, cols)
  end

  def seat(["L" | tail], rows, cols) do
    {left, _} = Enum.split(cols, div(length(cols), 2))
    seat(tail, rows, left)
  end

  def seat(["R" | tail], rows, cols) do
    {_, right} = Enum.split(cols, div(length(cols), 2))
    seat(tail, rows, right)
  end
end
