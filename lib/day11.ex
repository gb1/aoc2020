defmodule Day11 do
  def part1 do
    File.read!("inputs/day11.txt")
    |> String.replace("L", "💺")
    |> String.replace(".", "⬜")
    |> String.split("\n", trim: true)
    |> parse_input()
    |> solve()
  end

  def solve(seats) do
    new_seats = tick(seats)

    if seats == new_seats do
      seats
      |> Enum.filter(fn {_, v} ->
        v == "🧘"
      end)
      |> length()
    else
      solve(new_seats)
    end
  end

  def parse_input(input) do
    rows = hd(input) |> String.codepoints() |> length()
    cols = input |> length()

    IO.inspect({rows, cols})

    for x <- 0..(rows - 1), y <- 0..(cols - 1), reduce: %{} do
      acc -> Map.put(acc, {x, y}, input |> Enum.at(y) |> String.codepoints() |> Enum.at(x))
    end
  end

  def get_adj_seats(seats, {x, y}) do
    [
      seats[{x - 1, y - 1}],
      seats[{x - 1, y}],
      seats[{x - 1, y + 1}],
      seats[{x, y - 1}],
      seats[{x, y + 1}],
      seats[{x + 1, y + 1}],
      seats[{x + 1, y}],
      seats[{x + 1, y - 1}]
    ]
    |> Enum.reject(&(&1 == nil))
    |> Enum.reject(&(&1 == "⬜"))
  end

  def tick(seats) do
    for {{x, y}, v} <- seats, reduce: %{} do
      acc ->
        new_seat = update_seat(seats, {x, y}, v)
        Map.put(acc, {x, y}, new_seat)
    end
  end

  def update_seat(_seats, _, "⬜"), do: "⬜"

  def update_seat(seats, {x, y}, "💺") do
    adj_seats = get_adj_seats(seats, {x, y})

    cond do
      Enum.all?(adj_seats, &(&1 == "💺")) -> "🧘"
      true -> "💺"
    end
  end

  def update_seat(seats, {x, y}, "🧘") do
    adj_seats = get_adj_seats(seats, {x, y})
    adj_seats = Enum.filter(adj_seats, &(&1 == "🧘"))

    cond do
      length(adj_seats) >= 4 -> "💺"
      true -> "🧘"
    end
  end

  def print_seats(seats) do
    for x <- 0..9, reduce: "" do
      acc ->
        acc <>
          "\n" <>
          for y <- 0..9, reduce: "" do
            acc -> acc <> seats[{x, y}]
          end
    end
    |> IO.puts()
  end

  # PART 2 - so many similar named functions so move down here :-)

  def part2 do
    File.read!("inputs/day11.txt")
    |> String.replace("L", "💺")
    |> String.replace(".", "⬜")
    |> String.split("\n", trim: true)
    |> parse_input()
    |> solve2()
  end

  def solve2(seats) do
    new_seats = tick2(seats)

    if seats == new_seats do
      seats
      |> Enum.filter(fn {_, v} ->
        v == "🧘"
      end)
      |> length()
    else
      solve2(new_seats)
    end
  end

  def tick2(seats) do
    for {{x, y}, v} <- seats, reduce: %{} do
      acc ->
        new_seat = update_seat2(seats, {x, y}, v)
        Map.put(acc, {x, y}, new_seat)
    end
  end

  def update_seat2(_seats, _, "⬜"), do: "⬜"

  def update_seat2(seats, {x, y}, "💺") do
    adj_seats = get_line_of_sight_seats(seats, {x, y})

    cond do
      Enum.all?(adj_seats, &(&1 == "💺")) -> "🧘"
      true -> "💺"
    end
  end

  def update_seat2(seats, {x, y}, "🧘") do
    adj_seats = get_line_of_sight_seats(seats, {x, y})
    adj_seats = Enum.filter(adj_seats, &(&1 == "🧘"))

    cond do
      length(adj_seats) >= 5 -> "💺"
      true -> "🧘"
    end
  end

  def get_line_of_sight_seats(seats, {x, y}) do
    [
      get_seat_up(seats, {x, y}),
      get_seat_down(seats, {x, y}),
      get_seat_left(seats, {x, y}),
      get_seat_right(seats, {x, y}),
      get_seat_sw(seats, {x, y}),
      get_seat_se(seats, {x, y}),
      get_seat_ne(seats, {x, y}),
      get_seat_nw(seats, {x, y})
    ]
    |> Enum.reject(&(&1 == nil))
    |> Enum.reject(&(&1 == "⬜"))
  end

  def get_seat_up(seats, {x, y}) do
    seat = seats[{x, y - 1}]

    if seat == "⬜" do
      get_seat_up(seats, {x, y - 1})
    else
      seat
    end
  end

  def get_seat_down(seats, {x, y}) do
    seat = seats[{x, y + 1}]

    if seat == "⬜" do
      get_seat_down(seats, {x, y + 1})
    else
      seat
    end
  end

  def get_seat_left(seats, {x, y}) do
    seat = seats[{x - 1, y}]

    if seat == "⬜" do
      get_seat_left(seats, {x - 1, y})
    else
      seat
    end
  end

  def get_seat_right(seats, {x, y}) do
    seat = seats[{x + 1, y}]

    if seat == "⬜" do
      get_seat_right(seats, {x + 1, y})
    else
      seat
    end
  end

  def get_seat_se(seats, {x, y}) do
    seat = seats[{x + 1, y + 1}]

    if seat == "⬜" do
      get_seat_se(seats, {x + 1, y + 1})
    else
      seat
    end
  end

  def get_seat_sw(seats, {x, y}) do
    seat = seats[{x - 1, y + 1}]

    if seat == "⬜" do
      get_seat_sw(seats, {x - 1, y + 1})
    else
      seat
    end
  end

  def get_seat_nw(seats, {x, y}) do
    seat = seats[{x - 1, y - 1}]

    if seat == "⬜" do
      get_seat_nw(seats, {x - 1, y - 1})
    else
      seat
    end
  end

  def get_seat_ne(seats, {x, y}) do
    seat = seats[{x + 1, y - 1}]

    if seat == "⬜" do
      get_seat_ne(seats, {x + 1, y - 1})
    else
      seat
    end
  end
end
