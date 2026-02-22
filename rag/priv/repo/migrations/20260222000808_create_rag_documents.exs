defmodule Rag.Repo.Migrations.CreateRagDocuments do
  use Ecto.Migration

  def change do
    create table(:rag_documents) do
      add :content, :text, null: false
      add :embedding, :vector, size: 384, null: false
      add :metadata, :map

      timestamps()
    end
  end
end
