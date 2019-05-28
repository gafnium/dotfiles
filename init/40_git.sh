
config_file=${HOME}/.gitconfig.private

touch $config_file
grep "excludesFile" <$config_file >/dev/null && return 1

cat >>$config_file <<EOF
[core]
  excludesFile = ${HOME}/.gitignore_global
[http]
  cookieFile = ${HOME}/.gitcookies
  saveCookies = true
EOF
#| tee -a $config_file