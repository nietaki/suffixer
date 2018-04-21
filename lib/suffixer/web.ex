defmodule Suffixer.Web do
  use Ace.HTTP.Service, [cleartext: true]

  def handle_request(request = %{path: []}, config) do
    handle_request(%{request | path: ["s", "on"]}, config)
  end

  def handle_request(_request = %{path: ["s", suffix]}, _config) do
    response(:ok)
    |> set_body("#{suffix}\n\nbar\nbaz")
  end

  def handle_request(_, _) do
    response(:not_found)
  end

end
