defmodule Day9 do
  def part1 do
    numbers =
      File.read!("inputs/day9.txt")
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)

    find_invalid_number(numbers, numbers, 0)
  end

  def find_invalid_number([], _numbers, _index), do: :none_found

  def find_invalid_number([head | tail], numbers, index) do
    if index < 25 do
      find_invalid_number(tail, numbers, index + 1)
    else
      case check_valid(head, numbers, index) do
        true -> find_invalid_number(tail, numbers, index + 1)
        false -> head
      end
    end
  end

  def check_valid(head, numbers, index) do
    chunk = Enum.slice(numbers, (index - 25)..(index - 1))

    sums =
      for i <- chunk do
        for n <- chunk do
          if i != n do
            i + n
          end
        end
      end
      |> List.flatten()

    # if not (head in sums) do
    #   IO.inspect(index)
    #   IO.inspect(chunk)
    #   IO.inspect(sums)
    #   IO.inspect(head)
    # end

    head in sums
  end

  def part2 do
    numbers =
      File.read!("inputs/day9.txt")
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)

    for i <- 0..999 do
      find_range(numbers, i, 999)
    end

    :done
  end

  def find_range(_numbers, _start, -1), do: :done

  def find_range(_numbers, start, finish) when start >= finish, do: :done

  def find_range(numbers, start, finish) do
    chunk = Enum.slice(numbers, start..finish)

    if Enum.sum(chunk) == 556_543_474 do
      sorted = Enum.sort(chunk)
      IO.inspect(List.first(sorted) + List.last(sorted))
    else
      find_range(numbers, start, finish - 1)
    end
  end
end
