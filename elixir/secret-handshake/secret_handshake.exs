defmodule SecretHandshake do
  use Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    masks = %{
      0 => &(&1),
      1 => &["wink" | &1],
      2 => &["double blink" | &1],
      4 => &["close your eyes" | &1],
      8 => &["jump" | &1],
      16 => &Enum.reverse(&1),
    }

    Enum.reduce(0..4, [], &masks[(1 <<< &1) &&& code].(&2))
    |> Enum.reverse
  end
end
