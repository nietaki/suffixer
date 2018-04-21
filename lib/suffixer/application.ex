defmodule Suffixer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do

    port_string = System.get_env("PORT") || "8888"
    port = String.to_integer(port_string)

    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Suffixer.Worker.start_link(arg)
      # {Suffixer.Worker, arg},
      {Suffixer.Web, [_config = [], [port: port]]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Suffixer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
