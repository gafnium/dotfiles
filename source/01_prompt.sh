
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
esac

screens_count() { screen -list | awk 'BEGIN{ N=0 }{N=$1}END{if(N > 0){ print "[Screen]"}}'; }

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

if [[ "$(which screen)" ]]; then
    if [ "$color_prompt" = yes ]; then
        PS1='\[\033[01;31m\]$(screens_count)\[\033[01;32m\]$PS1'
    else
        PS1='$(screens_count)$PS1'
    fi
fi

unset color_prompt force_color_prompt

# Allow prompt to be restored to default.
if [[ "${#__PROMPT_DEFAULT[@]}" == 0 ]]; then
  __PROMPT_DEFAULT=("$PS1" "$PS2" "$PS3" "$PS4")
fi

# The default prompt.
function prompt_default() {
  unset PROMPT_COMMAND
  for i in {1..4}; do
    eval "PS$i='${__PROMPT_DEFAULT[i-1]}'"
  done
}

# An uber-simple prompt for demos / screenshots.
function prompt_zero() {
  prompt_default
  PS1='$ '
}


