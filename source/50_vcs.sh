
# Git shortcuts

alias git-fresh-master='git co master && git pull --rebase --no-stat origin master'
alias git-to-fresh-master='git stash save && git co master && git pull --rebase --no-stat origin master && git stash pop'
alias gti=git
alias gitex='git stash save&&git pull --rebase &&git push origin HEAD&&git stash pop'

