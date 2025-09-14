#!/bin/bash

function set_up() {
  ROOT_DIR="$(dirname "${BASH_SOURCE[0]}")/.."
  source "$ROOT_DIR/src/docker.sh"
}

test_dockerll() {
  local output=$(dockerll)

  # output header
  local first_line=$(echo "$output" | head -n 1)
  assert_contains "NAMES " "$first_line"
  assert_contains " STATUS " "$first_line"
  assert_contains " NETWORKS " "$first_line"
  assert_contains " PORTS" "$first_line"

  # output shell-dev-tools container
  local second_line=$(echo "$output" | sed -n '2p') # @TODO: what if it's not the 2. line?
  assert_contains "shell-dev-tools " "$second_line"
  assert_matches " Up [0-9]+ minutes " "$second_line"
  assert_contains " shell-dev-tools_default" "$second_line"
}
