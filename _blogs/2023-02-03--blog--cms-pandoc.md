---
title: CMS using Pandoc and Friends
date: 2023-02-03 Fri 14:38
filename: 2023-02-03--blog--cms-pandoc
author: Arumoy Shome
abstract: |
    Some tools & techniques I use to run a no non-sense blog using static
    html pages. All powered by a sane file naming convension, plaintext
    documents writing in markdown and exported to html using pandoc and
    other unix cli tools.
---

[In a prior post](2022-03-04--blog--website-management-pandoc), I
shared my humble system for running a static website using pandoc.
Since that post, I have replaced several manual steps in the process
with automated bash scripts.

# Creating and naming new posts

I use the following human and machine readable naming convention for
all my posts.

```
YYYY-MM-DD--<category>--<title>
```

Within the post, I use yaml metadata to record additional information
related to the post such as its title, date, author and a short
abstract.

```yaml
---
title: foo bar baz
author: John Doe
date: 2023-09-09
abstract: |
    This is the abstract for this post. This abstract shows up on the
    index page automatically! Read on to learn how I do this.
---
```

Although the naming convention is clear, writing it is a bit
cumbersome. Note that I also need to write the same information
twice---once within the file in the yaml metadata, and again when
naming the file. To reduce chances of human error, and make my life a
bit easier, I automate the process of creating a new post using the
following python script.

```python
#!/usr/bin/env python3

import os
import subprocess
import sys
import argparse
from datetime import datetime

EXT = ".md"
TIMESTAMP = datetime.now()
TIMESTAMP = TIMESTAMP.__format__("%Y-%m-%d %a %H:%M")
TODAY = datetime.now()
TODAY = TODAY.__format__("%Y-%m-%d")

parser = argparse.ArgumentParser()
parser.add_argument(
    "title",
    help="Title of new content",
)
parser.add_argument(
    "-t",
    "--type",
    help="Type of content",
    choices=[
        "blog",
        "talk",
    ],
)
parser.add_argument(
    "-x",
    "--noedit",
    help="Do not open new file in EDITOR",
    action="store_true",
)
parser.add_argument(
    "-f",
    "--force",
    help="Do not ask for confirmation",
    action="store_true",
)
args = parser.parse_args()

if args.type:
    TYPE = args.type
else:
    TYPE = "blog"

TITLE = args.title.strip().lower().replace(" ", "-")
NAME = "--".join([TODAY, TYPE, TITLE])
FILE = f"_{TYPE}s/{NAME}{EXT}"

FRONTMATTER = [
    "---",
    "\n",
    f"title: {TITLE}",
    "\n",
    f"date: {TIMESTAMP}",
    "\n",
    f"filename: {NAME}",
    "\n",
    "author: Arumoy Shome",
    "\n",
    "abstract: |",
    "\n",
    "---",
]

if not args.force:
    confirm = input(f"Create {FILE}? [y]es/[n]o: ")

    if confirm.lower()[0] == "n":
        sys.exit("Terminated by user")

try:
    with open(f"{FILE}", "x") as f:
        f.writelines(FRONTMATTER)
except FileExistsError:
    sys.exit(f"{FILE} already exists")

if not args.noedit:
    subprocess.run([os.getenv("EDITOR"), f"{FILE}"])

sys.exit(f"{FILE} created")
```

The script has a `title` positional argument which is
mandatory. Additionally, the script can also accept a type of the post
using the `--type` or `-t` flag. With the `--force` or `-f` flag, the
script does not ask for any confirmation when creating files. By
default, the script will open the newly created post using the default
editor. However, this can be bypassed by passing the `--noedit` or
`-x` flag. The script automatically creates the yaml frontmatter for
the post and names it in the specified format.

# Automatically generating index pages

I have two index pages on my website---the [blogs](blogs) page which
list all the blogposts I have written and the [talks](talks) page
which lists all the talks I have given in the past. Previously, I was
creating these pages manually. However, with a bit of unix
shell scripting, I have now managed to do this automatically!

I use the following script to generate the blogs and the talks index
pages.

```bash
#!/usr/bin/env bash

# generate blogs.md
TMP=$(mktemp)
[[ -e blogs.md ]] && rm blogs.md
find _blogs -name '*.md' |
  sort --reverse |
  while read -r file; do
    pandoc --template=_templates/index.md "$file" --to=markdown >>"$TMP"
  done

cat _templates/blogs-intro.md "$TMP" >>blogs.md
rm "$TMP"

# generate talks.md
TMP=$(mktemp)
[[ -e talks.md ]] && rm talks.md
find _talks -name '*.md' |
  sort --reverse |
  while read -r file; do
    pandoc --template=_templates/index.md "$file" --to=markdown >>"$TMP"
  done

cat _templates/talks-intro.md "$TMP" >>talks.md
rm "$TMP"
```

First we find all relevant markdown pages that we want to export to
html using `find`. Next, we `sort` the results in chronological order
such that the latest posts show up at the top of the page. The final
part is the most interesting bit. We use pandoc's templating system to
extract the date, title and abstract of each file and generate in
intermediate markdown file in the format that I want each post to show
on the index page. Here is the template file that I use.

```

# ${date} ${title}
$if(abstract)$

${abstract}

$endif$
$if(filename)$
[[html](${filename})]

$endif$
```

All that is left to do is stitch everything together using `cat` to
generate the final file.

# Putting everything together using `make`

Once the index pages are created, I use the following script to export
all markdown files to html.

```bash
#!/usr/bin/env bash

find . -name "*.md" -not -path "*_templates*" |
  while read -r file; do
    pandoc --template=public -o docs/"$(basename "${file/%.md/.html}")" "$file"
  done
```

To automate the entire build process I use GNU make. I have a single
`all` target which simply runs the `create-indices` and `publish`
scripts in the right order.

```make
all:
	bin/create-indices
	bin/publish
```

# Further optimisations

The `create-indices` script is currently sequential. You can imagine
that this will keep getting slower as the number of posts
increases. This step can be further optimised making the template
extraction step parallel using `xargs` and then sorting the results.

In the `publish` script, we are converting all markdown files to
html. Here, we can make the markdown file selection process smarter by
using `git ls-files`. This will allow us to only select modified and
untracked markdown files.
