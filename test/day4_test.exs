defmodule Day4Test do
  use ExUnit.Case

  test "test valid functions" do
    assert Day4.byr_valid?(%{"byr" => "2002"}) == true
    assert Day4.byr_valid?(%{"byr" => "2003"}) == false

    assert Day4.hgt_valid?(%{"hgt" => "60in"}) == true
    assert Day4.hgt_valid?(%{"hgt" => "190cm"}) == true
    assert Day4.hgt_valid?(%{"hgt" => "190in"}) == false
    assert Day4.hgt_valid?(%{"hgt" => "190"}) == false

    assert Day4.hcl_valid?(%{"hcl" => "#123abc"}) == true
    assert Day4.hcl_valid?(%{"hcl" => "#123abz"}) == false
    assert Day4.hcl_valid?(%{"hcl" => "123abc"}) == false

    assert Day4.ecl_valid?(%{"ecl" => "brn"}) == true
    assert Day4.ecl_valid?(%{"ecl" => "wat"}) == false

    assert Day4.pid_valid?(%{"pid" => "000000001"}) == true
    assert Day4.pid_valid?(%{"pid" => "0123456789"}) == false
  end
end
