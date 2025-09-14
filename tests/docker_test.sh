#!/bin/bash

function set_up() {
  ROOT_DIR="$(dirname "${BASH_SOURCE[0]}")/.."
  source "$ROOT_DIR/src/docker.sh"
}

test_dockerll() {
  local output=$(dockerll)

  assert_greater_or_equal_than 2 "$(echo "$output" | wc -l)"

  # output header
  local first_line=$(echo "$output" | head -n 1)
  assert_contains "NAMES " "$first_line"
  assert_contains " STATUS " "$first_line"
  assert_contains " NETWORKS " "$first_line"
  assert_contains " PORTS" "$first_line"
}

test_dockerll_filtered_by_name() {
  local output=$(dockerll --filter name=shell-dev-tools)

  assert_line_count 2 "$output"

  # output header
  local first_line=$(echo "$output" | head -n 1)
  assert_contains "NAMES " "$first_line"
  assert_contains " STATUS " "$first_line"
  assert_contains " NETWORKS " "$first_line"
  assert_contains " PORTS" "$first_line"

  # output shell-dev-tools container
  local second_line=$(echo "$output" | sed -n '2p')
  assert_contains "shell-dev-tools " "$second_line"
  assert_matches " Up [0-9]+ (seconds|minutes) " "$second_line"
  assert_contains " shell-dev-tools_default" "$second_line"
}
