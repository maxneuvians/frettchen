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

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger],
     mod: {Frettchen.Application, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
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
end
