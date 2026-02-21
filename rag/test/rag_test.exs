defmodule RagTest do
  use ExUnit.Case
  doctest Rag

  test "greets the world" do
    assert Rag.hello() == :world
  end
end
