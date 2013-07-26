defmodule Pullrequests.GithubPR do
  @doc """
  bash version
  function pr () {
    local base=$1
    if [ -z "$1" ]; then
      base="master"
    fi
    local repo=`git remote -v | grep -m 1 "(push)" | sed -e "s/.*github.com[:/]\(.*\)\.git.*/\1/"`
    local branch=`git name-rev --name-only HEAD`
    echo "... creating pull request for branch \"$branch\" to \"$base\" in \"$repo\""
    open https://github.com/$repo/compare/$base...$branch
  }
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
  bash version:
  function fpr () {
    echo git fetch origin pull/$1/head:pr$1
    git fetch origin pull/$1/head:pr$1
    echo git checkout pr$1
    git checkout pr$1
  }
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
