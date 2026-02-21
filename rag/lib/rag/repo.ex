defmodule Rag.Repo do
  use Ecto.Repo,
    otp_app: :rag,
    adapter: Ecto.Adapters.Postgres
end
