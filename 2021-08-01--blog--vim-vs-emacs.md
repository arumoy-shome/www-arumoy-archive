---
title: Vim vs. Emacs
author: Arumoy Shome
date: [2021-08-01 Sun 15:12]
---

After 5 years of using vim, I switched to emacs in 2021. In this
article, I lay down some of my observations along with my rationale
for ultimately switching back to vim.

The biggest selling point for Emacs is org-mode. Back then, I was
spending a lot of time thinking about and developing an efficient
system for managing information (see
[[file:zettel--productivity.org][productivity]]). Following this,
I was interested in carrying out this task in plaintext. When early
efforts to create a solution using unix tools failed (see commit
[[https://github.com/arumoy-shome/dotfiles/commit/1661626][1661626]]),
I developed a workflow using emacs and org-mode (see
[[file:zettel--research-workflow.org][research workflow]]).

There are several reasons for switching back to Vim, the primary one
being that org is exclusive to emacs and thus results in a "vendor
lock-in" situation. Versus, in Vim I use markdown to write text which
is more universal, has a larger community thus more tools and
information is available.

Another major motivation to move back to vim was that I prefer to work
in the shell environment. My workflow---whether that is writing or
coding---involves typing followed by running commands in the
shell. I found that the tight integration with the shell in emacs was
lacking for my needs. For instance, on osx, the `PATH` environment
variable is not properly setup in emacs (it requires manual setup
using `exec-path`). This results in a lot of plumbing for trivial
tasks such as writing and building code (working with python and
virtualenv was a nightmare!). Although emacs provides a shell written
in emacs-lisp along with a full terminal emulator, they never felt
quite as powerful and comfortable as a proper terminal emulator such
as iTerm.

I am fast in vim. Initially I did not notice this difference when I
moved to Emacs. However, since switching back, I noticed that I can
type what I am thinking in vim. I was not able to do that in emacs.

Ultimately, it all comes down to a tradeoff between visual looks
versus editing speed and shell environment. Things look a little nicer
in emacs since its a gui (working with pros is especially pleasing in
emacs). However, I am willing to make this compromise for a more
productive working environment.
