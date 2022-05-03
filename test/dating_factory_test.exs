defmodule DatingFactoryTest do
  use ExUnit.Case

  import DatingFactory, only: [sigil_d: 2]

  def datetime(year, month, day, hour, minute, second) do
    date = Date.new!(year, month, day)
    time = Time.new!(hour, minute, second, 000_000)

    DateTime.new!(date, time)
  end

  describe "~d/2" do
    test "parses full date" do
      assert ~d[Apr 24, 1981 - 3:33pm] == ~U[1981-04-24T15:33:00.000000Z]
    end

    test "date without year assumes current year" do
      now = DateTime.utc_now()

      assert ~d[Apr 24 - 3:33pm] == datetime(now.year, 4, 24, 15, 33, 0)
    end

    test "date without day or year assumes current day and year" do
      now = DateTime.utc_now()

      assert ~d[Apr - 3:33pm] == datetime(now.year, 4, now.day, 15, 33, 0)
    end

    test "date without a time assumes 00:00:00" do
      assert ~d[Apr 24, 1981] == datetime(1981, 4, 24, 0, 0, 0)
    end

    test "time without a date assumes the current date" do
      now = DateTime.utc_now()

      assert ~d[4:11pm] == datetime(now.year, now.month, now.day, 16, 11, 0)
    end

    test "parses all sorts of dates" do
      assert ~d[Jan 1, 2014] == datetime(2014, 1, 1, 0, 0, 0)
      assert ~d[Feb 23, 1979] == datetime(1979, 2, 23, 0, 0, 0)
      assert ~d[Mar 12, 1922] == datetime(1922, 3, 12, 0, 0, 0)
      assert ~d[Mar 12, 1922] == datetime(1922, 3, 12, 0, 0, 0)
      assert ~d[May 2, 1942] == datetime(1942, 5, 2, 0, 0, 0)
    end

    test "assumes current year when no year given" do
      now = DateTime.utc_now()

      assert ~d[Apr 24] == datetime(now.year, 4, 24, 0, 0, 0)
    end
  end

  test "parses just hour with am/pm" do
    now = Date.utc_today()

    assert ~d[2pm] == datetime(now.year, now.month, now.day, 14, 0, 0)
    assert ~d[11am] == datetime(now.year, now.month, now.day, 11, 0, 0)
  end

  test "parses hour and minutes with am/pm" do
    now = Date.utc_today()

    assert ~d[4:04am] == datetime(now.year, now.month, now.day, 4, 4, 0)
    assert ~d[10:04pm] == datetime(now.year, now.month, now.day, 22, 4, 0)
  end

  test "parses hour, minutes, and seconds with am/pm" do
    now = Date.utc_today()

    assert ~d[11:04:56pm] == datetime(now.year, now.month, now.day, 23, 4, 56)
    assert ~d[11:04:56am] == datetime(now.year, now.month, now.day, 11, 4, 56)
  end
end
