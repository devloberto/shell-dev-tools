git_delete_all_branches_but_default()
{
  local default
  default="master"
  # thanks to omz https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh#L35
  command git rev-parse --git-dir &> /dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{master,main,trunk,stable,mainline,default}
  do
    if command git show-ref -q --verify "$ref"
    then
      default="$(basename "$ref")" # zsh only syntax: default="${ref:t}"
      break
    fi
  done
 
  local output
  output=$(git checkout "$default" && git branch | grep -v "$default" | xargs -I{} git branch -D {} 2>&1)
  echo "$output" | while read -r output_line; do
    echo "$output_line"
  done
  if [[ ! "$output" =~ "Deleted branch" ]]; then
    echo "No branch to delete"
  fi
}
