defmodule Bob do
  def hey(input) do
    cond do
      silence?(input) -> "Fine. Be that way!"
      shouting_a_question?(input) -> "Calm down, I know what I'm doing!"
      shouting?(input) -> "Whoa, chill out!"
      question?(input) -> "Sure."
      true -> "Whatever."
    end
  end

  defp silence?(input) do
    String.trim(input) == ""
  end

  defp shouting_a_question?(input) do
    shouting?(input) && question?(input)
  end

  defp shouting?(input) do
    uppercase?(input) && no_letters?(input)
  end

  defp question?(input) do
    String.ends_with?(input, "?")
  end

  defp uppercase?(input) do
    input == String.upcase(input)
  end

  defp no_letters?(input) do
    String.upcase(input) != String.downcase(input)
  end
end
