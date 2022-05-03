defmodule D do
  @time ~r/\A([0-9][0-9]?):?([0-6][0-9])?:?([0-6][0-9])?(am|pm)/

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

    Time.new!(hour, minute, second)
  end

  defp to_integer(""), do: 0
  defp to_integer(string), do: String.to_integer(string)
end
