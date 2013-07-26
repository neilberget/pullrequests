defmodule Pullrequests.CLI do

  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up working with
  pull requests.
  """

  def run(argv) do
    argv
      |> parse_args
      |> process
  end

  def process(:help) do
    IO.puts """
    usage: pullrequests new [target | master]
           pullrequests fetch <num>
    """
    System.halt(0)
  end

  def process(args) do
    Pullrequests.GithubPR.process(args)
  end

  @doc """
  `argv` can be -h or --help with returns :help.

  Otherwise it is one of the following commands:
  * `new` which returns `{ :new }`
  * fetch num which return `{ :fetch, num }`
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean ],
                                     aliases:  [ h:    :help ])

    case parse do 
    { [ help: true ], _ }    -> :help
    { _, [ "new" ] }         -> { :new, "master" }
    { _, [ "new", target ] } -> { :new, target }
    { _, [ "fetch", arg ] }  -> { :fetch, arg }
    _                        -> :help
    end
  end

end
