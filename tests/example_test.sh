#!/bin/bash

test_subject="../src/git_delete_all_branches_but_main.sh"

git_repo_path="/tmp/test-repo-$(date +%s)"

function set_up() {
  source $test_subject

  mkdir $git_repo_path
  cd $git_repo_path
}

function provide_initial_branch_names() {
  run_test master
  run_test main
  run_test my-special-main-branch-name
}

# multi_invoker provide_initial_branch_names
function test_git_delete_all_branches_but_main_handles_MASTER_branch() {
  # setup
  touch init-file.txt
  git init --initial-branch=$@
  git add .
  git commit -m "initial commit"
  git branch # @TODO remove debugging output
  git checkout -b test-branch-1
  touch 1-file.txt
  git add .
  git commit -m "first feature"
  git branch # @TODO remove debugging output
  git checkout -b test-branch-2
  touch 2-file.txt
  git add .
  git commit -m "second feature"
  git branch # @TODO remove debugging output
  git checkout -b test-branch-3
  touch 3-file.txt
  git add .
  git commit -m "third feature"
  git branch # @TODO remove debugging output
  sleep 5

  assert_equals "$(git --version)" "git version 2.45.2"
}

function tear_down() {
  rm -rf $git_repo_path
}
