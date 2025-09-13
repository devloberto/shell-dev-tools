git_delete_all_branches_but_default()
( # use subshell to have local functions with __ prefix
  __git_main_branch() { 
    # thanks to omz https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh#L35
    command git rev-parse --git-dir &> /dev/null || return
    local ref
    for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,stable,master}
    do
      if command git show-ref -q --verify "$ref"
      then
        echo "${ref:t}"
        return 0
      fi
    done
    echo master
    return 1
  }

  local main
  main="$(__git_main_branch)" # @TODO where is the implementation of this function?
  echo "$main"
  return
  # @TODO replace omz git aliases by real git commands
  local output=$(gco $main && gb | grep -v "$main" | xargs -I{} git branch -D {} 2>&1)
  echo "$output" | while read -r output_line; do
    echo $output_line
  done
  if [[ ! "$output" =~ "Deleted branch" ]]; then
    echo "No branch to delete"
  fi
)
