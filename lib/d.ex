defmodule D do
  @date ~r/\A(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s?([0-9][0-9]?)?,?\s?([0-9][0-9][0-9][0-9])?/
  @time ~r/\A([0-9][0-9]?):?([0-6][0-9])?:?([0-6][0-9])?(am|pm)/

  def sigil_d(string, []) do
    string
    |> String.replace(~r/\s+/, " ")
    |> String.split(" - ")
    |> parse()
  end

  def parse([date, time]) do
    DateTime.new!(parse_date(date), parse_time(time))
  end

  def parse([date_or_time]) do
    cond do
      date?(date_or_time) ->
        DateTime.new!(parse_date(date_or_time), Time.utc_now())

      time?(date_or_time) ->
        DateTime.new!(Date.utc_today(), parse_time(date_or_time))

      true ->
        raise "Oops"
    end
  end

  def date?(string), do: string =~ @date
  def time?(string), do: string =~ @time

  def parse_date(string) do
    case Regex.run(@date, string, capture: :all_but_first) do
      [month, day, year] ->
        month = parse_month(month)
        day = to_integer(day)
        year = to_integer(year)

        Date.new!(year, month, day)

      [month, day] ->
        %{year: year} = DateTime.utc_now()
        month = parse_month(month)
        day = to_integer(day)

        Date.new!(year, month, day)

      [month] ->
        %{year: year, day: day} = DateTime.utc_now()
        month = parse_month(month)

        Date.new!(year, month, day)

      nil ->
        raise "oops"
    end
  end

  defp parse_month("Jan"), do: 1
  defp parse_month("Feb"), do: 2
  defp parse_month("Mar"), do: 3
  defp parse_month("Apr"), do: 4
  defp parse_month("May"), do: 5
  defp parse_month("Jun"), do: 6
  defp parse_month("Jul"), do: 7
  defp parse_month("Aug"), do: 8
  defp parse_month("Sep"), do: 9
  defp parse_month("Oct"), do: 10
  defp parse_month("Nov"), do: 11
  defp parse_month("Dec"), do: 12

  def parse_time(string) do
    [hour, minute, second, period] = Regex.run(@time, string, capture: :all_but_first)
    hour = to_integer(hour)
    minute = to_integer(minute)
    second = to_integer(second)

    hour =
      if period == "pm" do
        hour + 12
      else
        hour
      end

    Time.new!(hour, minute, second, 000000)
  end

  defp to_integer(""), do: 0
  defp to_integer(string), do: String.to_integer(string)
end
