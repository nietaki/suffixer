defmodule Suffixer.MixProject do
  use Mix.Project

  def project do
    [
      app: :suffixer,
      version: "0.1.0",
      elixir: "~> 1.4",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Suffixer.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # this branch should only be used for hoplon integration tests
      # hence the hardcoded path
      {:hoplon, path: "..", app: false, runtime: false, optional: true},
      # used as the webserver
      {:ace, "0.16.0"},
      # the evil package
      {:evil_left_pad, ">= 0.3.0"},
      # not used, just showcases transitive dependencies,
      # pulls in mime package, which differs from github and is absolved in hoplon.lock
      {:plug, "~> 1.5.0"}
    ]
  end
end
