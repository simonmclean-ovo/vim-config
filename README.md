## Usage

Create `~/.vimrc` and add the line

```
source ~/.vim/configs/index.vim
```

## Prerequisites

Install bat syntax highlight in preview windows

```
brew install bat
```

To make FZF respect gitignore, install Silver Searcher.

```
brew install the_silver_searcher
```

Install Nerd Fonts.

Install lf

### Enable italics

This config includes some highlighting of special words which sets them to italic.
iTerm2 doesn't seem to like rendering italic and regular fonts at the same time.
To fix this create a file called `xterm-256color-italic.terminfo`, and insert the following:

To fix this, run `tic xterm-256color-italic.terminfo` (file is in this repo). Then in the iTerm preferences go to
Profiles > Terminal and set "Report Terminal Type" to "xterm-256color-italic".

Restart iTerm2.

## TODO

Continue splitting up the `index.vim` into smaller modules
