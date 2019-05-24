# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu || return 1

# Package management
alias update="sudo apt-get -qq update && sudo apt-get upgrade"
alias install="sudo apt-get install"
alias remove="sudo apt-get remove"
alias search="apt-cache search"
alias screen="screen -R"

alias say=spd-say

if [ -d $HOME/android-sdk ]; then
  export ANDROID_SDK_ROOT=$HOME/android-sdk
  export PATH=$PATH:$ANDROID_SDK_ROOT/tools
fi

# Make 'less' more.
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

