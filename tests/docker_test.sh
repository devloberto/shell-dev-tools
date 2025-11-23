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
  assert_matches " Up [a-zA-Z0-9 ]+ (seconds?|minutes?|hours?) " "$second_line"
  assert_contains " shell-dev-tools_default" "$second_line"
}

TEST_CONTAINER_NAME=test-shell-dev-tools-unit-try_docker

test_try_docker() {
  # source_file="$(current_dir)/../src/docker.sh"
  # tmp_log_file=temp_file

  # nohup source $source_file && TESTING=true try_docker "$TEST_CONTAINER_NAME" shell-dev-tools:debian-trixie >"$tmp_log_file" 2>&1 &
  output=$(UNIT_TESTING=true try_docker "$TEST_CONTAINER_NAME" shell-dev-tools:debian-trixie tail -f /dev/null)
  assert_contains "docker run -it --rm --name $TEST_CONTAINER_NAME --entrypoint=tail shell-dev-tools:debian-trixie -f /dev/null" "$output"

  sleep 1
  docker ps --format '{{.Names}}' | grep -q "^$TEST_CONTAINER_NAME\$"
  assert_successful_code # assert the TEST_CONTAINER is running

  output=$(docker exec "$TEST_CONTAINER_NAME" cat /etc/issue)
  assert_equals "Debian GNU/Linux 13 \n \l" "$output"

  # cp "$tmp_log_file" /tmp/test-shell-dev-tools.log
}

tear_down_after_script() {
  # stop and remove test_container if it exists
  if docker ps -a --format '{{.Names}}' | grep -q "^$TEST_CONTAINER_NAME\$"; then
    docker rm -f "$TEST_CONTAINER_NAME" >/dev/null 2>&1
  fi
}
