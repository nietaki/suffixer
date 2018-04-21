defmodule Suffixer.Web do
  use Ace.HTTP.Service, [cleartext: true]

  def handle_request(request = %{path: []}, config) do
    handle_request(%{request | path: ["s", "lon"]}, config)
  end

  def handle_request(_request = %{path: ["s", suffix]}, _config) do
    words = Suffixer.Server.get_words_for_suffix(suffix)
    words_column = Enum.join(words, "\n")
    header = "words that end in \"#{suffix}\":\n\n"

    response(:ok)
    |> set_body(header <> words_column)
  end

  def handle_request(_, _) do
    response(:not_found)
  end

end
