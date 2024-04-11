defmodule Completex.GoogleBertTest do
  @moduledoc false
  use ExUnit.Case

  alias Completex.ChatCompletion.GoogleBert

  describe "should translate something" do
    @tag timeout: :infinity
    test "translate" do
      name = :test
      GoogleBert.start_link(name: name)

      {predictions, _opts} =
        Completex.ChatCompletion.call("How old [MASK] you?",
          engine: GoogleBert,
          name: name
        )
        |> Keyword.pop!(:predictions)

      %{token: token, score: _score} =
        predictions |> Enum.min_by(fn %{score: score} -> 1 - score end)

      assert token == "are"
    end
  end
end
