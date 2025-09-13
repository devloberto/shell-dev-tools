#!/bin/bash

git_repo_path="/tmp/test-repo-$(date +%s)" # append unix timestamp to avoid unexpected side effects

function set_up() {
  ROOT_DIR="$(dirname "${BASH_SOURCE[0]}")/.."
  source "$ROOT_DIR/src/git_delete_all_branches_but_default.sh"

  mkdir "$git_repo_path"
  cd "$git_repo_path" || exit 1
}

function provide_initial_branch_names() {
  local branch_names=("master" "main" "trunk" "stable" "mainline" "default")
  echo "${branch_names[@]}"
}

# data_provider provide_initial_branch_names
function test_git_delete_all_branches_but_default() {
  # setup
  default_branch_name="$1"
  git init --initial-branch "$default_branch_name"
  git config init.defaultBranch "$default_branch_name"
  touch init-file.txt
  git add .
  git commit -m "initial commit"
  git checkout -b test-branch-1
  touch 1-file.txt
  git add .
  git commit -m "first feature"
  git checkout -b test-branch-2
  touch 2-file.txt
  git add .
  git commit -m "second feature"
  git checkout -b test-branch-3
  touch 3-file.txt
  git add .
  git commit -m "third feature"

  # execution
  git_delete_all_branches_but_default

  # assertion
  assert_equals "* $default_branch_name" "$(git branch)"
}

function tear_down() {
  rm -rf "$git_repo_path"
}
