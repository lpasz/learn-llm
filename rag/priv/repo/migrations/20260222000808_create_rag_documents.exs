defmodule Rag.Repo.Migrations.CreateRagDocuments do
  use Ecto.Migration

  def change do
    create table(:rag_documents) do
      add :content_hash, :string, null: false
      add :content, :text, null: false
      add :embedding, :vector, size: 768, null: false

      timestamps()
    end


    create unique_index(:rag_documents, [:content_hash])
  end
end
