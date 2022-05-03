defmodule D.MixProject do
  use Mix.Project

  def project do
    [
      app: :d,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application, do: []

  defp deps, do: []
end
