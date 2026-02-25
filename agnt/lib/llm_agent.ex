defmodule LLMAgent do
  # This system prompt is repeated every single turn — critical for 3B models
  @system """
  You are a STRICT JSON-ONLY AI agent. 
  You are FORBIDDEN from outputting ANY text except valid JSON.
  No explanations. No thinking steps. No "I will use...". No extra words at all.

  You have exactly TWO possible responses:

  1. To call a tool:
  {
    "action": "count_letters",
    "arguments": {
      "word": "the_word_here",
      "letter": "the_letter_here"
    }
  }

  2. ONLY when you have the complete final answer:
  {
    "final_answer": "short clean answer to the user"
  }

  HARD RULES:
  - Always output EXACTLY one of the two JSON objects above. Nothing else.
  - In "final_answer" NEVER mention tools, JSON, actions, calculations, or how you got the answer.
  - Just give the direct, clean answer.
  - If you need information, call the tool. Do not guess.
  - Never output anything outside the { } braces.
  """

  def agent(prompt) do
    initial_prompt = """
    #{@system}

    USER TASK:
    #{prompt}

    Respond with JSON only now:
    """

    agent_loop(initial_prompt)
  end

  def agent_loop(text) do
    res =
      text
      |> IO.inspect(label: :prompt)
      |> prompt()
      |> IO.inspect(label: :response)

    res
    |> JSON.decode()
    |> case do
      {:ok, %{"action" => "count_letters", "arguments" => %{"word" => a, "letter" => b}}} ->
        response = a |> String.codepoints() |> Enum.frequencies() |> Map.get(b)

        agent_loop(
        text <> """
        You decided to call:
        {
        "action": "count_letters",
        "arguments": { "word": "#{a}", "letter": #{b} }
        }
        Tool response (observation):
        ----- TOOL RESULT START -----
        There is exactly #{response} #{b}'s' in #{a}
        ----- TOOL RESULT END -----
        """)

      {:ok, %{"final_answer" => text}} ->
        text

      _ ->
        res
    end
  end

  @doc """
  This calls the local llm that we are running with ollama.

  We are running a very small model, to really show how dumb the answers are without RAG.

  The response is always... wierd, specially in Portuguese.

  ### Example:

    iex> Rag.LLM.chat("O que e Churrasco?")
    "Churrasco é um termo utilizado com algumas palavras em português para se referir à salsa ou barbecue, ou em forma mais formal como \"barbacoa\", \"carnavais de frango\", etc. Neste contexto, churrasco é uma mistura de salsa e carne, que pode ser preparada no terno de um machado (churrasco barbie) ou usando peixe (churrasco à vela)."

    iex> Rag.LLM.chat("What is Churrasco?")
    "Churrascó is a type of Argentine steakhouse or bar that specializes in grilling and roasting beef, pork, lamb, and other meats. The cuisine is typically served with side dishes such as chimichurri sauce, empanadas, fried potatoes, and coleslaw. Churrascos are known for their extensive menu of traditional Argentine steakhouse dishes like mariscos (fish stew), choripán (steak sandwich), and grilled octopus. Churrascó is typically open until late at night or early in the morning, so it can be a popular spot for nightlife enthusiasts."    

  """
  def prompt(prompt) do
    url = "http://localhost:11434/api/generate"

    body = %{
      model: "llama3.2:3b",
      prompt: prompt,
      stream: false
    }

    {:ok, response} =
      Req.post(url,
        json: body,
        receive_timeout: 160_000
      )

    response.body["response"]
  end
end
