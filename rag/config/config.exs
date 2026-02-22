# config/config.exs
import Config


config :rag, Rag.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "rag_dev",
  port: 5432,
  types: Rag.PostgrexTypes 

config :rag, ecto_repos: [Rag.Repo]
