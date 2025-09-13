#!/bin/bash

git_repo_path="/tmp/test-repo-$(date +%s)" # append unix timestamp to avoid unexpected side effects

function set_up() {
  ROOT_DIR="$(dirname "${BASH_SOURCE[0]}")/.."
  source "$ROOT_DIR/src/git_delete_all_branches_but_default.sh"

  git config --global user.email "shell@dev.tools"
  git config --global user.name "dev"

  mkdir "$git_repo_path"
  cd "$git_repo_path" || exit 1
}

function provide_initial_branch_names() {
  local branch_names=("master" "main" "trunk" "stable")
  echo "${branch_names[@]}"
}

# data_provider provide_initial_branch_names
function test_git_delete_all_branches_but_default() {
  # setup
  main_branch_name="$1"
  git init --initial-branch "$main_branch_name"
  git config init.defaultBranch "$main_branch_name"
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
  git_delete_all_branches_but_default

  assert_equals "$main_branch_name" "$(git_delete_all_branches_but_default)"
  # execution @TODO run git_delete_all_branches_but_default
  # git_delete_all_branches_but_main
  #
  # assertion @TODO and assert that only git_main_branch exists
  # assert_equals "$main_branch_name" "$(git branch)"
}

function tear_down() {
  rm -rf "$git_repo_path"
}
