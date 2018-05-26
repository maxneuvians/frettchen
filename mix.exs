defmodule Frettchen.Mixfile do
  use Mix.Project

  def project do
    [app: :frettchen,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     compilers: [:thrift | Mix.compilers],
     thrift: [
       files: Path.wildcard("thrift/**/*.thrift")
     ],
     name: "Frettchen",
     source_url: "https://github.com/maxneuvians/frettchen",
     homepage_url: "https://github.com/maxneuvians/frettchen",
     docs: [main: "Frettchen.Trace",
            extras: ["README.md"]
          ]
   ]
  end

  def application do
    [extra_applications: [:logger],
     mod: {Frettchen.Application, []}]
  end

  defp deps do
    [
      {:credo, "~> 0.9.1", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:gen_stage, "~> 0.13"},
      {:httpoison, "~> 1.0"},
      {:socket, "~> 0.3", only: [:test]},
      {:thrift, github: "pinterest/elixir-thrift"}
    ]
  end

  defp description do
    """
    Frettchen is a Jaeger client written completely in Elixir. 
    """
  end

  defp package do
    [# These are the default files included in the package
     files: ["lib", "thrift", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Max Neuvians"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/maxneuvians/frettchen",
              "Docs" => "https://github.com/maxneuvians/frettchen"}]
  end
end
