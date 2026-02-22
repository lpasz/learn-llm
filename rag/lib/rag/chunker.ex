defmodule Rag.Chunker do
  @chunk_size 2000
  @overlap 400

  def stream_chunks(path) do
    path
    |> File.stream!([], 2048)
    # Transform is like reduce for streams
    |> Stream.transform("", &accumulate_chunks/2)
  end

  defp accumulate_chunks(bytes, acc) do
    buffer = acc <> bytes
    chunk = String.slice(buffer, 0, @chunk_size)
    end_of_text = String.length(buffer)
    start_at_overlap = @chunk_size - @overlap
    rest = String.slice(buffer, start_at_overlap, end_of_text)

    {[chunk], rest}
  end
end
