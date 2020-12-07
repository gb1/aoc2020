defmodule Day7 do
  def part1 do
    File.read!("inputs/day7.txt")
    |> String.split("\n", trim: true)
    |> parse_lines(%{})
    |> find_bags(["shiny gold"], [])
    |> Enum.uniq()
    # take off one for "shiny gold" itself!
    |> length()
  end

  def find_bags(_, [], seen), do: seen

  def find_bags(graph, [head | tail], seen) do
    cond do
      Map.has_key?(graph, head) -> find_bags(graph, tail ++ graph[head], seen ++ [head])
      true -> find_bags(graph, tail, seen ++ [head])
    end
  end

  def parse_lines([], graph), do: graph

  def parse_lines([line | tail], graph) do
    [bag, bags] =
      line
      |> String.replace("bags", "")
      |> String.replace("bag", "")
      |> String.replace(".", "")
      |> String.replace(",", "")
      |> String.replace("  ", " ")
      |> String.split(" contain ")

    bags =
      bags
      |> String.split(~r{\d}, trim: true)
      |> Enum.map(&String.trim/1)

    graph =
      bags
      |> Enum.reduce(graph, fn x, acc ->
        Map.update(acc, x, [bag], &(&1 ++ [bag]))
      end)

    parse_lines(tail, graph)
  end

  def part2 do
    graph =
      File.read!("inputs/day7.txt")
      |> String.split("\n", trim: true)
      |> parse_lines2(%{})

    count_bags(graph, graph["shiny gold"]) - 1
  end

  def parse_lines2([], graph), do: graph

  def parse_lines2([head | tail], graph) do
    cond do
      String.contains?(head, "no other") ->
        parse_lines2(tail, graph)

      true ->
        [bag, bags] =
          head
          |> String.replace("bags", "")
          |> String.replace("bag", "")
          |> String.replace(".", "")
          |> String.replace(",", "")
          |> String.replace("  ", " ")
          |> String.split(" contain ")

        bags =
          bags
          |> String.split(~r{\d}, trim: true, include_captures: true)
          |> Enum.map(&String.trim/1)
          |> Enum.chunk_every(2)
          |> Enum.map(fn [no_of_bags, bag] ->
            {String.to_integer(no_of_bags), bag}
          end)

        parse_lines2(tail, Map.put(graph, bag, bags))
    end
  end

  def count_bags(_graph, nil), do: 1

  def count_bags(graph, children) do
    Enum.reduce(children, 1, fn {count, bag}, acc ->
      acc + count * count_bags(graph, graph[bag])
    end)
  end
end
