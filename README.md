# Learn LLM - Learning Projects in Elixir

Two focused learning projects demonstrating core LLM patterns: **RAG** (Retrieval-Augmented Generation) and **Agents** (agentic AI with tool use).

## Project Overview

### 🔍 RAG (Retrieval-Augmented Generation)
**Problem**: Small LLMs produce poor answers on unfamiliar topics.  
**Solution**: Embed external documents, retrieve relevant context, and augment prompts.

- Document chunking with overlap
- Vector embeddings via LLM
- PostgreSQL + pgvector storage
- Context retrieval for better answers

→ See [rag/README.md](rag/README.md)

### 🤖 Agnt (Agent with Tool Use)
**Problem**: Small LLMs can't reliably do multi-step reasoning or call tools.  
**Solution**: Strict JSON prompts, tool calling loops, and result feedback.

- JSON-only output enforcement
- Agent loop with tool execution
- Tool result feedback
- Forced multi-step reasoning

→ See [agnt/README.md](agnt/README.md)

## Key Learning Goals

Both projects use small models (3B parameters) running locally to showcase:

1. **How to improve small models** - They struggle without augmentation
2. **Prompt engineering** - Strict formats and repetition matter
3. **System design** - Chunking, storage, retrieval, iteration
4. **Tool integration** - How agents call external functions

## Setup

Both projects require:
- **Ollama** running locally with `llama3.2:3b` model
- **PostgreSQL** with pgvector (for RAG only)
- **Elixir ~> 1.18**

```bash
# Start Ollama (if not running)
ollama serve

# Setup RAG database
cd rag && mix ecto.create

# Setup dependencies
cd rag && mix deps.get
cd ../agnt && mix deps.get
```

## Quick Start

### RAG: Improve a Model's Knowledge
```bash
cd rag
iex -S mix

iex> Rag.raggfy("path/to/document.txt")
# Now queries about document content will have better answers
```

### Agent: Multi-Step Problem Solving
```bash
cd agnt
iex -S mix

iex> LLMAgent.agent("How many e's in 'hello'?")
# Agent calls count_letters tool and returns answer
```

## Architecture Patterns

### RAG Flow
```
Document → Chunker → Embed (LLM) → PostgreSQL (pgvector)
                                         ↓
                            Query → Retrieve → Augment Prompt → LLM Response
```

### Agent Flow
```
User Prompt → LLM (JSON) → Parse Action
                          ↓
                     Tool Call? → Execute Tool → Append Result → Loop
                     Final Answer? → Return
```

## Technology Stack

**Elixir**: Functional language with great pattern matching and pipes  
**Ollama**: Local LLM serving (no API key needed)  
**PostgreSQL + pgvector**: Vector storage and similarity search  
**Req**: HTTP client for LLM communication  

## Educational Value

These are intentionally simple projects to understand:
- Why RAG helps when models have gaps
- How agents make models more capable through iteration
- The importance of careful prompt engineering for small models
- How to integrate external tools and data with LLMs
