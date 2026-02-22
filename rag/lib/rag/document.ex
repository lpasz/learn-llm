defmodule Rag.Document do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rag_documents" do
    field :content, :string
    field :embedding, Pgvector.Ecto.Vector
    field :metadata, :map

    timestamps()
  end

  def changeset(doc, attrs) do
    doc
    |> cast(attrs, [:content, :embedding, :metadata])
    |> validate_required([:content, :embedding])
  end
end
