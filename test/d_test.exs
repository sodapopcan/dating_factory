defmodule DTest do
  use ExUnit.Case

  import D

  describe "parse_time/1" do
    test "parses just hour with am/pm" do
      assert parse_time("2pm") == Time.new!(14, 0, 0)
      assert parse_time("11am") == Time.new!(11, 0, 0)
    end
  end
end
