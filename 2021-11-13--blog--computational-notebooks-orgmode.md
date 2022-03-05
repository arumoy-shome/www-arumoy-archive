---
title: Computational Notebooks using Emacs & org-mode
author: Arumoy Shome
date: [2021-11-13 Sat 15:31]
---

I tried an experiment where I did data analysis in the
terminal. I wrote a python module consisting of all the analysis code
(where each method corresponds to a cell). I redirected the output to
files/images and viewed the results using unix commands/vim. I wrote
down my observations and interpretations of the results in a separate
markdown file.

The detachment of code, output and analysis lead to increased
cognitive overload. I realised that for data analysis, the order in
which we execute the cells is important. With the code and output
detached, it becomes challenging (and mentally taxing) to keep
everything updated.

Each output goes into a separate file which means the files need to be
opened manually. Contrast this to having the code blocks and their
corresponding outputs in the same viewport. Having them together is
not only cognitively less taxing  but also creates a tight and instant
feedback loop which is essential for data science or any experimental
work for that matter.

Markdown is also primitive compared to org-mode, it actually helps to
see the text output right in the org buffer rather than saving them in
separate files. Another benefit is that if the code is re-executed, we
can immediately see if the output changed or not. When the output is
saved in separate files, its often confusing to detect change when
viewing in the terminal.

The org-mode workflow only works on my local laptop (graphical
interface) however its the best solution for a data science workflow
without having to use notebooks.

To test the validity of using org-mode as computational notebooks,
I conducted the entire data analysis segment of my first research
project data using nothing but plaintext. I ran the analysis using
[org-mode](https://orgmode.org) and
[org-tangle](https://orgmode.org/manual/Extracting-Source-Code.html). This
allowed me to write down my code, its corresponding results and my
interpretation of those results all in a single place.

I find this workflow superior to jupyter notebooks for several
reasons:
1. Its all plaintext (not json metadata as is the case for
   Jupyter). This means that git diffs make total sense once again.
2. I can use org's export backend to generate html files (this also
   makes it easy to share via my website or as pdfs with others).
3. I get to use Emacs' windowing system (as opposed to Jupyter lab's
   mouse driven nonsense) along with everything its got to offer
   (dired, searching, viewing images, fuzzy matching, the works!)

The limitation however is that I am unsure how this workflow can be
scaled to remote systems. It seemed that this wouldn't work for
systems that sit behind a university firewall (thus requiring a hop
server in the middle for authentication). Although I am yet to test
this, a potential solution is to use a ssh tunnel.

I am aware of [TRAMP](https://www.gnu.org/software/tramp/) for
accessing remote files, although I have yet to try it out. I really
hope that combined with a ssh tunnel, I can continue to run data
analysis tasks from within emacs while utilizing the compute power of
remote hardware.

Another solution can be to use emacs directly in the terminal on the
remote server. However the problem of viewing images still is
a challenge. Another point to remember is that visualisations cannot
be done using all the data (for large datasets) since the output will
be cluttered. We need to use subsets for visualisations anyway, and
only require the server for performing the computations for
transformations, feature engineering and model training.
