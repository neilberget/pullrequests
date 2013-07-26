defmodule Pullrequests.GithubPR do
  @doc """
  Opens a web browser to the github compare page to create a new pull request
  """
  def process({:new, target}) do
    IO.puts "Creating new pull request against #{target}"
    System.cmd "open #{compare_url(target)}"
  end

  def compare_url(target) do
    "https://github.com/#{repo}/compare/#{target}...#{branch}"
  end

  def repo do 
    System.cmd("git remote -v | grep -m 1 '(push)' | sed -e 's/.*github.com[:/]\\(.*\\)\\.git.*/\\1/'")
      |> String.rstrip
  end

  def branch do
    System.cmd 'git name-rev --name-only HEAD'
  end

  @doc """
  Fetches the given pull request from github and checks it out
  """
  def process({:fetch, number}) do
    IO.puts "Fetching PR #{number}"

    fetch_pr number
    checkout "pr#{number}"
  end

  def fetch_pr(number) do
    System.cmd "git fetch origin pull/#{number}/head:pr#{number}"
  end

  def checkout(branch) do
    System.cmd "git checkout #{branch}"
  end
end
