defmodule Rag do
  @moduledoc """
  Documentation for `Rag`.
  """

  @doc """
  First naive chunker, we are doing the bare min
  """
  def raggfy(file) do
    file
    |> Rag.Chunker.stream_chunks()
    |> Enum.map(fn chunk ->
      embed = Rag.LLM.embed(chunk)

      {:ok, _} = Rag.Documents.create(chunk, embed)
    end)
  end
end
