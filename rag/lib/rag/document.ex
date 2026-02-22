defmodule Rag.Document do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rag_documents" do
    field(:content_hash, :string)
    field(:content, :string)
    field(:embedding, Pgvector.Ecto.Vector)

    timestamps()
  end

  def changeset(doc, attrs) do
    doc
    |> cast(attrs, [:content, :embedding, :content_hash])
    |> unique_constraint(:content_hash)
    |> validate_required([:content, :embedding, :content_hash])
  end
end
