defmodule NicoWeb.ViewHelpers.Nico do

  @spec convert_length_seconds(integer) :: String.t
  def convert_length_seconds(seconds) do
    minutes = div(seconds, 60)
    remainder = rem(seconds, 60)
    "#{minutes}:" <> String.pad_leading(Integer.to_string(remainder), 2, "0")
  end

  def convert_datetime(date_string) when is_binary(date_string) do
    case Timex.parse(date_string, "{ISO:Extended}") do
      {:ok, datetime} -> datetime2str(datetime)
      _ -> "pe:" <> date_string
    end
  end

  def convert_datetime(datetime) do
    datetime2str(datetime)
  end

  def datetime2str(datetime) do
    jpDatetime = Timex.to_datetime(datetime, "Asia/Tokyo")
    case Timex.format(jpDatetime, "{YYYY}-{0M}-{0D} {h24}:{0m}") do
      {:ok, str} -> str
      _ -> "fe"
    end
  end
end
