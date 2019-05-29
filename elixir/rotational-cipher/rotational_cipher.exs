defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.codepoints
    |> Enum.map(&shift_char(&1, shift))
    |> to_string
  end

  defp shift_char(<<c::utf8>>, shift) when c >= ?a and c <= ?z do
    ?a + Integer.mod((c - ?a) + shift, 26)
  end

  defp shift_char(<<c::utf8>>, shift) when c >= ?A and c <= ?Z do
    ?A + Integer.mod((c - ?A) + shift, 26)
  end

  defp shift_char(<<c::utf8>>, _shift) do
    c
  end
end
