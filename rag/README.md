# Rag

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `rag` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:rag, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/rag>.


## Making a dumb model provide good answers

Ask soemthing about churrasco, and got terrible answers, exactly what we wanted, a topic the LLM produces garbage.

Now i've found a pdf about the subject, it's not great, but lets see how this improves our questions.

```bash
pdftotext ~/Downloads/mini_biblia some-churrasco-pdf.txt
```
