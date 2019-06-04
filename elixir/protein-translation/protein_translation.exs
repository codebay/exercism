defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    rna
    |> split_rna_into_codons
    |> codons_to_proteins
    |> proteins_to_polypeptide
  end

  defp split_rna_into_codons(rna) do
    rna
    |> String.codepoints
    |> Enum.chunk_every(3)
    |> Enum.map(&to_string/1)
  end

  defp codons_to_proteins(codons) do
    Enum.map(codons, &of_codon/1)
  end

  defp proteins_to_polypeptide(proteins) do
    try do
      polypeptide = Enum.reduce_while(proteins, [], fn x, acc ->
        case x do
          {:ok, "STOP"} -> {:halt, acc}
          {:ok, protein} -> {:cont, [protein | acc]}
          {:error, _} -> throw(:break)
        end
      end)
      |> Enum.reverse
      {:ok, polypeptide}
    catch
      :break -> {:error, "invalid RNA"}
    end
  end

  @proteins %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP",
  }

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    with {:ok, protein} <- Map.fetch(@proteins, codon) do
      {:ok, protein}
    else
      :error -> {:error, "invalid codon"}
    end
  end
end
