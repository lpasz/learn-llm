# RAG (Retrieval-Augmented Generation)

A learning project demonstrating **Retrieval-Augmented Generation** in Elixir. RAG improves LLM responses by embedding external documents and retrieving relevant context before generating answers.

## What This Does

This project shows how to:
- **Chunk** documents into manageable pieces with configurable overlap
- **Embed** chunks using vector embeddings via an LLM API
- **Store** embeddings in PostgreSQL with pgvector support
- **Retrieve** relevant document chunks to augment LLM prompts
- **Generate** better answers by providing context to the model

## The Problem It Solves

Small language models (like 3B parameter models) produce poor answers on topics they lack training data for. By providing relevant document context retrieved from a knowledge base, the model can give much better answers—this is RAG.

**Example**: Asking a 3B model "O que é Churrasco?" without context produces garbage. With relevant PDF content about churrasco in the prompt context, it produces accurate answers.

## Project Structure

- `lib/rag.ex` - Main RAG pipeline (ragify function)
- `lib/rag/chunker.ex` - Document chunker (2000 char chunks with 400 char overlap)
- `lib/rag/llm.ex` - LLM API client (calls local Ollama instance)
- `lib/rag/documents.ex` - Vector database operations
- `lib/rag/repo.ex` - Ecto repository for database access

## Getting Started

### Prerequisites
- PostgreSQL with pgvector extension
- Ollama running locally with llama3.2:3b model
- Elixir ~> 1.18

### Setup
```bash
cd rag
mix deps.get
mix ecto.create
```

### Usage

Convert a document to embeddings and store in the database:
```elixir
Rag.raggfy("path/to/document.txt")
```

Example workflow with a PDF:
```bash
# Convert PDF to text first
pdftotext ~/Downloads/document.pdf document.txt

# Then embed and store it
iex> Rag.raggfy("document.txt")
```

## Dependencies

- **pgvector** - PostgreSQL vector extension for storing embeddings
- **ecto_sql** - Database operations
- **postgrex** - PostgreSQL adapter
- **req** - HTTP client for LLM API calls
- **jason** - JSON encoding/decoding
