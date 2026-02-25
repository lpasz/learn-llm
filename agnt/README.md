# Agnt (LLM Agent)

A learning project demonstrating **agentic AI** in Elixir. An agent is an AI system that can call tools to solve problems, iterating until it reaches a final answer.

## What This Does

This project shows how to:
- **Design strict JSON-only prompts** to control small model outputs
- **Implement an agent loop** that parses JSON responses and executes tools
- **Call external tools** (functions) based on LLM decisions
- **Iterate** with tool results fed back into the LLM until completion
- **Force reasoning** in small 3B parameter models that struggle with complex tasks

## The Problem It Solves

Small language models don't reliably perform multi-step reasoning or tool calls without careful prompt engineering. This agent uses:
- A system prompt that enforces JSON-only output
- A strict format that only allows two actions: calling a tool or providing a final answer
- Tool result feedback loops to guide the model toward correct answers

## Project Structure

- `lib/llm_agent.ex` - Main agent implementation with loop logic
  - `agent/1` - Entry point for agent with a user prompt
  - `agent_loop/1` - Main loop that alternates between LLM calls and tool execution
  - `prompt/1` - Calls local Ollama LLM instance

## How It Works

1. **Initial Prompt** - System prompt + user task, demands JSON response
2. **LLM Call** - Calls local llama3.2:3b model via Ollama
3. **Parse Response** - Extracts JSON action or final_answer
4. **Tool Execution** - If action is a tool call, execute it
5. **Tool Result Feedback** - Append tool result to context and loop back to step 2
6. **Termination** - When LLM returns `final_answer`, return it to user

## Current Tool

- `count_letters` - Counts occurrences of a letter in a word
  - Arguments: `word` (string), `letter` (string)
  - Returns: Count of occurrences

Example: The agent can answer "How many 'l's in 'hello'?" by calling the tool.

## Getting Started

### Prerequisites
- Ollama running locally with llama3.2:3b model
- Elixir ~> 1.18

### Setup
```bash
cd agnt
mix deps.get
```

### Usage

```elixir
iex> LLMAgent.agent("How many times does the letter 'e' appear in the word 'hello'?")
```

The agent will:
1. Receive the prompt
2. Decide to call the `count_letters` tool
3. Execute it (3 'e's in 'hello' - wait, 1 'e')
4. Feed result back and provide final answer

## Dependencies

- **req** - HTTP client for Ollama API calls

## Design Notes

- **System prompt is repeated every turn** - Small models need constant reinforcement
- **JSON-only output** - Eliminates natural language confusion
- **No explanations** - Forces direct answers and tool calls
- **Tool result format** - Clearly delimited with START/END markers

