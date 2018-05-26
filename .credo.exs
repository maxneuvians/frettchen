%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["config/", "lib/", "test/"],
        excluded: ["lib/jaeger", ~r"/_build/", ~r"/deps/"]
      },
    color: true
    }
  ]
}
