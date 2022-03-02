---
title: Keeping Terminal & Vim Colors in Sync
author: Arumoy Shome
date: [2022-03-02 Wed 16:16]
---

When you are staring at text all day long, little things such as the
colors of your terminal screen & text editor start to matter. There is
vast information & knowledge on color theory but very few colorscheme
authors take this into account.

For the longest time, I was a devotee of the [base16
colorschemes](http://chriskempson.com/projects/base16/) by Chris
Kempson (oldest commit in my dotfiles repo that mentions base16 was
almost 5 years ago, retrieved using the `git log --grep 'base16'
--reverse` command).

Although the base16 themes work well, I did not find the text legible,
especially in the light colorschemes. Fortunately, I stumbled upon
Modus themes developed by Protesilaos Stavrou which conform to the
highest standards of contrast, making the text in both the light
& dark themes, extremely legible.

Although originally developed for Emacs, Protesilaos includes the
`modus-themes-exporter.el` library as part of his dotfiles
configuration (see [his
article](https://protesilaos.com/codelog/2021-02-22-modus-themes-exporter/)
for relevant links). Using this, I ported the colorschemes to vim and
included them as [part of my
config](https://github.com/arumoy-shome/dotfiles).

I was a long term user of iTerm however, the wonderful [GPU
accelerated kitty terminal](https://sw.kovidgoyal.net/kitty/)
developed by Kovid Goyal soon stole my heart. Kitty ships with several
themes, including the modus themes.

The final piece of the puzzle, is a few lines of bash along with some
nifty configurations for kitty & vim to keep colorschemes across the
shell & editors in sync.

I wrote `modus` (part of my dotfiles) which enables this. `modus`
accepts a single parameter which can be `light` or `dark` and switches
to the corresponding theme in all instances of kitty. Without any
paramters, `modus` toggles the theme. Following are the contents of
`modus` as of [2022-03-02 Wed 22:20]. Refer to my dotfiles for the
latest version.

```bash
#!/usr/bin/env bash

# modus: switch between modus light (operandi) & dark (vivendi)
# themes.

# This script makes a few assumptions:
# 1. You are using kitty as your terminal <https://sw.kovidgoyal.net/kitty/>
# 2. You have a light & dark theme for kitty stored in kitty's config
#    dir (which is $XDG_CONFIG_HOME/kitty by default)
# 3. You exclusively use the wonderful modus themes by Protesilaos
#    Stravrou for your shell <https://protesilaos.com/emacs/modus-themes>
# 4. You have some plumbing on the vim side to automatically update
#    the `background' setting using autocommands. See
#    <https://github.com/arumoy-shome/dotfiles/blob/c3b172dc05446aff20a5660f09699ffcc89e0379/vim/autoload/aru.vim#L95>
#    and
#    <https://github.com/arumoy-shome/dotfiles/blob/c3b172dc05446aff20a5660f09699ffcc89e0379/vim/plugin/autocmds.vim#L27>
#    for examples.

# Usage: modus [COLOR]
# This script is meant to be called from the command line. Without any
# arguments, modus switches between the light & dark themes. It does
# so by looking at the first line of the
# $XDG_DATA_HOME/modus/background file which should contain the word
# `light' or `dark'.
# With the optional argument COLOR---which can be `light' or
# `dark'---it switches to the specified colorscheme.

[[ ! -d "$XDG_DATA_HOME/modus" ]] && mkdir -p "$XDG_DATA_HOME/modus"
MODUS_CURRENT_BG_FILE="$XDG_DATA_HOME/modus/background"
KITTY_LIGHT_THEME="$XDG_CONFIG_HOME/kitty/light-theme.conf"
KITTY_DARK_THEME="$XDG_CONFIG_HOME/kitty/dark-theme.conf"
KITTY_CURRENT_THEME="$XDG_CONFIG_HOME/kitty/current-theme.conf"

__update_emacs() {
  # update the colorscheme in Emacs. Assumes that the modus-themes
  # package <https://github.com/protesilaos/modus-themes> is installed
  # and in the load-path. The output is redirected to /dev/null to
  # avoid printing error messages if no emacs server is running.

  if [[ "$1" == "light" ]]; then
    emacsclient --eval '(modus-themes-load-operandi)' > /dev/null
  else
    emacsclient --eval '(modus-themes-load-vivendi)' > /dev/null
  fi
}

__update_kitty() {
  # Update the colorscheme in kitty. Assumes that you are using
  # a recent version of kitty with the `themes' kitten available & the
  # colorschemes are installed.
  # Note that we use a temp file to redirect the config output. This
  # is to avoid changing the kitty.conf file (causes false positive in
  # the vcs). Your kitty.conf should contain the following line:
  #
  #     include current-theme.conf

  TMPFILE="$(mktemp)"

  if [[ "$1" == "light" ]]; then
    kitty +kitten themes --config-file-name="$TMPFILE" Modus Operandi
  else
    kitty +kitten themes --config-file-name="$TMPFILE" Modus Vivendi
  fi

  rm -f "$TMPFILE" # cleanup
}

__light() {
  # Switch to the light (operandi) theme. Some preliminary error
  # handling is done when $KITTY_LIGHT_THEME does not exist.

  if [[ ! -f $KITTY_LIGHT_THEME ]]; then
    echo "Error: $KITTY_LIGHT_THEME does not exist."
    echo "Info: Use kitty +kitten themes to save the theme first."
    return 1
  fi

  ln -sf "$KITTY_LIGHT_THEME" "$KITTY_CURRENT_THEME"
  __update_kitty light
  __update_emacs light
  echo light > "$MODUS_CURRENT_BG_FILE"
}

__dark() {
  # Switch to the dark (vivendi) theme. Some preliminary error
  # handling is done when $KITTY_DARK_THEME does not exist.

  if [[ ! -f $KITTY_DARK_THEME ]]; then
    echo "Error: $KITTY_DARK_THEME does not exist."
    echo "Info: Use kitty +kitten themes to save the theme first."
    return 1
  fi

  ln -sf "$KITTY_DARK_THEME" "$KITTY_CURRENT_THEME"
  __update_kitty dark
  __update_emacs dark
  echo dark > "$MODUS_CURRENT_BG_FILE"
}

__toggle() {
  # Toggle between light and dark themes. Some preliminary error
  # handling is done when $MODUS_CURRENT_BG_FILE does not exist or is
  # not in the expected format.

  if [[ ! -f $MODUS_CURRENT_BG_FILE ]]; then
    echo "Error: $MODUS_CURRENT_BG_FILE does not exist."
    echo "Info: set a colorscheme using modus {light,dark} first."
    return 1
  fi

  if [[ ! -r $MODUS_CURRENT_BG_FILE || ! -s $MODUS_CURRENT_BG_FILE ]]; then
    echo "Error: Something is not right with $MODUS_CURRENT_BG_FILE."
    echo "Info: Make sure that it is readable & not empty."
    return 1
  fi

  local CURRENT_BG="$(head -n 1 "$MODUS_CURRENT_BG_FILE")"
  case "$CURRENT_BG" in
    light)
      __dark
      ;;
    dark)
      __light
      ;;
    *)
      echo "Error: Something is not right with $MODUS_CURRENT_BG_FILE."
      echo "Info: Make sure it is valid & try again."
      ;;
  esac
}

main() {
  if [[ "$#" -eq 0 ]]; then
    __toggle
  else
    case "$1" in
      light)
        __light
        ;;
      dark)
        __dark
        ;;
      *)
        # Do nothing
        ;;
    esac
  fi
}

main "$@"
```

To preserve the colorscheme across kitty sessions, `modus` creates
a `current-theme.conf` in kitty's config dir. This file should be
sourced in `kitty.conf` using the following snippet.

```conf
include current-theme.conf
```

The configuration on vim side is a bit more involved. `modus` writes
the current theme type (light or dark) in
`$XDG_DATA_HOME/modus/background`. The following autoloaded function
reads this file and sets the appropriate colorscheme in vim. To learn
more about autoloaded functions in vim, consult the manual using
`:help autoload-functions`.

```vimscript
function! aru#sync_background() abort
  let s:bg_file = expand('~/.local/share/modus/background')

  if filereadable(s:bg_file)
    let s:bg = readfile(s:bg_file, '', 1)
    execute 'colorscheme ' . s:bg[0]
  else
    colorscheme default
  endif
endfunction
```

The above function is called once on startup. I like to keep all code
related to colors in the `after/` directory to avoid overrides from
external packages. The following line of vimscript placed in
`after/plugin/color.vim` does the trick.

```vimscript
call aru#sync_background()
```

If we run `modus` from another shell, the colors in existing vim
sessions does not update. To account for this, we can fire an autocmd
every time vim gains focus. To learn more about vim autocmds, consult
the manual using `:help autocmd`.

```vimscript
function! AruHighlightAutocmds() abort
  augroup AruHighlight
    autocmd!
    autocmd FocusGained * call aru#sync_background()
  augroup END
endfunction
call AruHighlightAutocmds()
```

Here are some screenshots of the end result.

![Modus dark](assets/image/modus-dark.png)

![Modus light](assets/image/modus-light.png)
