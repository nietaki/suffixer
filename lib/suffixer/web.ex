defmodule Suffixer.Web do
  use Ace.HTTP.Service, [port: 8080, cleartext: true]

  def handle_request(_request = %{path: ["s", suffix]}, config) do
    response(:ok)
    |> set_body("foo\nbar\nbaz")
  end

  def handle_request(_, _) do
    response(:not_found)
  end

end
