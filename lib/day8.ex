defmodule Day8 do
  def part1 do
    File.read!("inputs/day8.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_instruction/1)
    |> Enum.with_index()
    |> Enum.map(fn {x, y} -> {y, x} end)
    |> Enum.into(%{})
    |> run(0, 0, [])
  end

  def parse_instruction(line) do
    [inst, sign, amount] = String.split(line, ~r/\+|\-/, include_captures: true)
    {String.trim(inst), sign, String.to_integer(amount)}
  end

  def run(instructions, index, acc, executed) do
    if index in executed do
      acc
    else
      {instruction, sign, count} = instructions[index]

      case instruction do
        "nop" -> run(instructions, index + 1, acc, executed ++ [index])
        "jmp" -> run(instructions, add(sign, index, count), acc, executed ++ [index])
        "acc" -> run(instructions, index + 1, add(sign, acc, count), executed ++ [index])
      end
    end
  end

  def add("+", x, y), do: x + y
  def add("-", x, y), do: x - y

  def part2 do
    instructions =
      File.read!("inputs/day8.txt")
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_instruction/1)
      |> Enum.with_index()
      |> Enum.map(fn {x, y} -> {y, x} end)
      |> Enum.into(%{})

    for i <- 0..632 do
      solve(instructions, i, 0, 0, [])
    end
    |> Enum.filter(&(&1 != :terminated))
  end

  def solve(_instructions, flip, index, acc, _executed) when index == 633, do: acc

  def solve(instructions, flip, index, acc, executed) do
    if index in executed do
      :terminated
    else
      {instruction, sign, count} = instructions[index]

      case instruction do
        "nop" ->
          # if flip === index do
          # solve(instructions, flip, add(sign, index, count), acc, executed ++ [index])
          # else
          solve(instructions, flip, index + 1, acc, executed ++ [index])

        # end

        "jmp" ->
          if flip === index do
            solve(instructions, flip, index + 1, acc, executed ++ [index])
          else
            solve(instructions, flip, add(sign, index, count), acc, executed ++ [index])
          end

        "acc" ->
          solve(instructions, flip, index + 1, add(sign, acc, count), executed ++ [index])
      end
    end
  end
end
