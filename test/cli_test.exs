Code.require_file "test_helper.exs", __DIR__

defmodule CliTest do
  use ExUnit.Case

  import Pullrequests.CLI, only: [ parse_args: 1 ]

  test ":help returned by option parsing with -h and --help options" do 
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "the new command is parsed with master by default" do
    assert parse_args(["new"]) == { :new, "master" }
  end

  test "the new command is parsed with optional target" do
    assert parse_args(["new", "RELEASE"]) == { :new, "RELEASE" }
  end

  test "the fetch command is parsed" do
    assert parse_args(["fetch", "99"]) == { :fetch, "99" }
  end
end
