defmodule DTest do
  use ExUnit.Case

  import D

  describe "parse_time/1" do
    test "parses just hour with am/pm" do
      assert parse_time("2pm") == Time.new!(14, 0, 0)
      assert parse_time("11am") == Time.new!(11, 0, 0)
    end

    test "parses hour and minutes with am/pm" do
      assert parse_time("4:04am") == Time.new!(4, 4, 0)
      assert parse_time("10:04pm") == Time.new!(22, 4, 0)
    end

    test "parses hour, minutes, and seconds with am/pm" do
      assert parse_time("11:04:56pm") == Time.new!(23, 4, 56)
      assert parse_time("11:04:56am") == Time.new!(11, 4, 56)
    end
  end
end
