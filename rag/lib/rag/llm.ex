defmodule Rag.LLM do
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
  def chat(prompt) do
    url = "http://localhost:11434/api/generate"

    body = %{
      model: "tinyllama",
      prompt: prompt,
      stream: false
    }

    {:ok, response} =
      Req.post(url,
        json: body
      )

    response.body["response"]
  end

  def embed(text) do
    url = "http://localhost:11434/api/embeddings"

    body = %{
      model: "nomic-embed-text",
      prompt: text,
    }

    {:ok, response} =
      Req.post(url,
        json: body
      )

    response.body["embedding"]
  end
end
