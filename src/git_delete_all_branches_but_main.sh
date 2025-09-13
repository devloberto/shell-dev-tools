git_delete_all_branches_but_main() {
    local main=$(git_main_branch)
    local output=$(gco $main && gb | grep -v "$main" | xargs -I{} git branch -D {} 2>&1)
    echo "$output" | while read -r output_line; do
      echo $output_line
    done
    if [[ ! "$output" =~ "Deleted branch" ]]; then
      echo "No branch to delete"
    fi
}
