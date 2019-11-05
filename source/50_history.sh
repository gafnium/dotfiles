# History settings

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace:erasedups

# append to the history file, don't overwrite it
shopt -s histappend
# compress multiline command to one line
shopt -s cmdhist

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
HISTTIMEFORMAT="%d/%m/%y %T "
HISTIGNORE='ls:bg:fg:history'

# bind Ctrl-K to erase currently selected (or last if readline input is empty) line from history
bind -x '"\C-K":"kill-last-hist-line; history -c; history -r"'


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
