defmodule D do
  def parse_time(string) do
    [hour] = Regex.run(~r/\A[0-9][0-9]?/, string)
    hour = String.to_integer(hour)

    hour =
      if String.ends_with?(string, "pm") do
        hour + 12
      else
        hour
      end

    Time.new!(hour, 0, 0)
  end
end
