# Pullrequests

Helper for managing github pull requests.

Installation:

Place the pullrequests script in your path.

Usage:

To create a new pull request against an optionally specified target branch (defaults to master):

    pullrequests new [<target>]

To fetch a pull request by it's number and check it out:

    pullrequests fetch <number>


TODO
----
* make fetch fail  with helpful message if you have local uncommitted changes
