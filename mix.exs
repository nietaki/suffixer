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
      # checks packages for hidden code
      {:hoplon, ">= 0.3.0"},
      # used as the webserver
      {:ace, "0.16.0"},
      # the evil package
      {:evil_left_pad, ">= 0.3.0"},
      # not used showcases transitive dependencies,
      # pulls in mime, which differs and is absolved in hoplon.lock
      {:plug, "~> 1.5.0"}
    ]
  end
end
