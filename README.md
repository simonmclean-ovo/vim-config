## Usage

Create `~/.vimrc` and add the line

```
source ~/.vim/configs/index.vim
```

## Prerequisites

To make FZF respect gitignore, install Silver Searcher.

```
brew install the_silver_searcher
```

Install Nerd Fonts.

Install ranger and ranger_devicons.

### Enable italics

This config includes some highlighting of special words which sets them to italic.
iTerm2 doesn't seem to like rendering italic and regular fonts at the same time.
To fix this create a file called `xterm-256color-italic.terminfo`, and insert the following:

```
xterm-256color-italic|xterm with 256 colors and italic,
  sitm=\E[3m, ritm=\E[23m,
  use=xterm-256color,
```

Then run `tic xterm-256color-italic.terminfo` on the file. Then in the iTerm preferences go to
Profiles > Terminal and set "Report Terminal Type" to "xterm-256color-italic".

Restart iTerm2.

## TODO

Continue splitting up the `index.vim` into smaller modules
