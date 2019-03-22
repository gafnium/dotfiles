paths=(
  ~/.local/bin
  $DOTFILES/bin
  ~/yatool
  ~/depot_tools
)

export PATH
for p in "${paths[@]}"; do
  [[ -d "$p" ]] && PATH="$p:$(path_remove "$p")"
done
unset p paths


source $DOTFILES/vendor/z/z.sh