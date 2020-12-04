defmodule Day4 do
  def part1 do
    File.read!("inputs/day4.txt")
    |> String.split("\n\n", trim: true)
    |> Enum.map(&parse_passport/1)
    |> Enum.map(&remove_cid/1)
    |> Enum.map(&length/1)
    |> Enum.filter(&(&1 === 7))
    |> length()
  end

  def part2 do
    File.read!("inputs/day4.txt")
    |> String.split("\n\n", trim: true)
    |> Enum.map(&parse_passport/1)
    |> Enum.map(&remove_cid/1)
    |> Enum.filter(&(length(&1) === 7))
    |> Enum.map(&Enum.into(&1, %{}))
    |> Enum.map(&valid?/1)
    |> Enum.filter(& &1)
    |> length()
  end

  def parse_passport(raw) do
    raw
    |> String.replace(" ", "\n")
    |> String.split("\n", trim: true)
    |> Enum.map(fn x ->
      [k, v] = String.split(x, ":")
      {k, v}
    end)
  end

  def remove_cid(passport) do
    passport
    |> Enum.filter(fn {k, _v} ->
      k != "cid"
    end)
  end

  def valid?(passport) do
    [
      byr_valid?(passport),
      iyr_valid?(passport),
      eyr_valid?(passport),
      hgt_valid?(passport),
      hcl_valid?(passport),
      ecl_valid?(passport),
      pid_valid?(passport)
    ]
    |> Enum.all?(&(&1 === true))
  end

  def byr_valid?(%{"byr" => byr}),
    do: String.to_integer(byr) >= 1920 and String.to_integer(byr) <= 2002

  def iyr_valid?(%{"iyr" => iyr}),
    do: String.to_integer(iyr) >= 2010 and String.to_integer(iyr) <= 2020

  def eyr_valid?(%{"eyr" => eyr}),
    do: String.to_integer(eyr) >= 2020 and String.to_integer(eyr) <= 2030

  def hgt_valid?(%{"hgt" => hgt}) do
    cond do
      String.contains?(hgt, "in") ->
        {height, _} = Integer.parse(hgt)
        height >= 59 and height <= 76

      String.contains?(hgt, "cm") ->
        {height, _} = Integer.parse(hgt)
        height >= 150 and height <= 193

      true ->
        false
    end
  end

  def hcl_valid?(%{"hcl" => hcl}) do
    result = Regex.match?(~r/^#[a-f0-9]{6}/, hcl)
  end

  def ecl_valid?(%{"ecl" => ecl}) do
    ecl in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
  end

  def pid_valid?(%{"pid" => pid}) do
    Regex.match?(~r/^[0-9]{9}/, pid) and length(String.codepoints(pid)) === 9
  end
end
