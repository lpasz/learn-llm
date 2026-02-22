defmodule Rag.Documents do
  alias Rag.Document
  alias Rag.Repo

  def create(content, embedding) do
    hash = :crypto.hash(:sha256, content) |> Base.encode16(case: :lower)

    %Document{}
    |> Document.changeset(%{content_hash: hash, content: content, embedding: embedding})
    |> Repo.insert(on_conflict: :nothing, conflict_target: [:content_hash])
  end
end
