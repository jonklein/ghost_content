defmodule GhostContent.MixProject do
  use Mix.Project

  @source_url "https://github.com/jonklein/ghost_content"

  def project do
    [
      app: :ghost_content,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      preferred_cli_env: [
        vcr: :test,
        "vcr.delete": :test,
        "vcr.check": :test,
        "vcr.show": :test
      ],
      name: "ghost_content",
      source_url: @source_url,
      description: "An Elixir client for the Ghost publishing platform's Content API.",
      docs: [
        main: "readme",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 2.2"},
      {:jason, "~> 1.2"},
      {:ex_doc, "~> 0.31", only: :dev, runtime: false},
      {:exvcr, "~> 0.14.4", only: :test}
    ]
  end

  defp package do
    [
      maintainers: ["Jonathan Klein"],
      licenses: ["MIT"],
      links: %{
        GitHub: @source_url
      }
    ]
  end
end
