defmodule Day15 do
  def solve do
    # map numbers => {last_turn, turn_before_that}
    # numbers = %{3 => {1, nil}, 1 => {2, nil}, 2 => {3, nil}}
    # take_turn(4, 6, numbers)

    numbers = %{
      1 => {1, nil},
      0 => {2, nil},
      18 => {3, nil},
      10 => {4, nil},
      19 => {5, nil},
      6 => {6, nil}
    }

    # 1,0,18,10,19,6
    take_turn(7, 6, numbers)
  end

  # part 1
  # def take_turn(2021, last_number, numbers), do: last_number
  # part 2
  def take_turn(30_000_001, last_number, _numbers), do: last_number

  def take_turn(turn, last_number, numbers) do
    case numbers[last_number] do
      nil ->
        take_turn(turn + 1, 0, Map.put(numbers, 0, {turn, nil}))

      {_t, nil} ->
        {last_zero, _} = numbers[0]
        take_turn(turn + 1, 0, Map.put(numbers, 0, {turn, last_zero}))

      {t, prev} ->
        last =
          case numbers[t - prev] do
            {l, _} -> l
            nil -> nil
          end

        take_turn(turn + 1, t - prev, Map.put(numbers, t - prev, {turn, last}))
    end
  end
end
