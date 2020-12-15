defmodule Day14 do
  def make_bitstring(input) do
    input
    |> String.to_integer()
    |> Integer.to_string(2)
    |> pad()
  end

  def pad(bitstring) do
    if String.length(bitstring) == 36 do
      bitstring
    else
      pad("0" <> bitstring)
    end
  end

  def apply_mask(input, mask) do
    Enum.zip(String.codepoints(input), String.codepoints(mask))
    |> Enum.map(fn {x, m} ->
      if m == "X" do
        x
      else
        m
      end
    end)
    |> List.to_string()
  end

  def part1() do
    File.read!("inputs/day14.txt")
    |> String.split("\n", trim: true)
    |> parse(%{}, nil)
  end

  def parse([], memory, _mask) do
    memory
    |> Enum.map(fn {_k, v} ->
      String.to_integer(v, 2)
    end)
    |> Enum.sum()
  end

  def parse([head | tail], memory, mask) do
    if String.contains?(head, "mask") do
      [_, new_mask] = head |> String.split("mask = ")
      parse(tail, memory, new_mask)
    else
      [address, value] =
        head
        |> String.split("mem[")
        |> tl()
        |> Enum.at(0)
        |> String.split("] = ")

      new_memory = update_memory(memory, address, value, mask)
      parse(tail, new_memory, mask)
    end
  end

  def update_memory(memory, address, value, mask) do
    new_value =
      value
      |> make_bitstring()
      |> apply_mask(mask)

    Map.put(memory, address, new_value)
  end
end
