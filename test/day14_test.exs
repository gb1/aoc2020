defmodule Day14Test do
  use ExUnit.Case

  test "make bitstring" do
    assert Day14.make_bitstring(11) ==
             "000000000000000000000000000000001011"
  end

  test "test mask" do
    assert Day14.apply_mask(
             "000000000000000000000000000000001011",
             "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X"
           ) == "000000000000000000000000000001001001"
  end
end
