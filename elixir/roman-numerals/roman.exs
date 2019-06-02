defmodule Roman do

  @conversion %{
    1 => %{1 => "I", 2 => "II", 3 => "III", 4 => "IV", 5 => "V", 6 => "VI", 7 => "VII", 8 => "VIII", 9 => "IX"},
    2 => %{1 => "X", 2 => "XX", 3 => "XXX", 4 => "XL", 5 => "L", 6 => "LX", 7 => "LXX", 8 => "LXXX", 9 => "XC"},
    3 => %{1 => "C", 2 => "CC", 3 => "CCC", 4 => "CD", 5 => "D", 6 => "DC", 7 => "DCC", 8 => "DCCC", 9 => "CM"},
    4 => %{1 => "M", 2 => "MM", 3 => "MMM"}
  }

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) when number > 0 and number < 4000 do
    number
    |> Integer.digits
    |> list_of_columns_and_digits
    |> Enum.map(fn {c, d} -> @conversion[c][d] end)
    |> Enum.join
  end

  defp list_of_columns_and_digits(l) do
    Enum.count(l)..1
    |> Enum.to_list
    |> Enum.zip(l)
  end
end
