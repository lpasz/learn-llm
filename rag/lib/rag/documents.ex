defmodule Rag.Documents do
  import Ecto.Query

  alias Rag.Document
  alias Rag.Repo

  def list do
    Repo.all(Document)
  end

  def similar(promt) do
    query_vector = Rag.LLM.embed(promt)

    Document
    |> order_by([d], fragment("? <=> ?", d.embedding, ^query_vector))
    |> where([d], fragment("? <=> ? <= ?", d.embedding, ^query_vector, 0.35))
    |> limit(3)
    |> Repo.all()
  end

  def create(content, embedding) do
    hash = :crypto.hash(:sha256, content) |> Base.encode16(case: :lower)

    %Document{}
    |> Document.changeset(%{content_hash: hash, content: content, embedding: embedding})
    |> Repo.insert(on_conflict: :nothing, conflict_target: [:content_hash])
  end
end
