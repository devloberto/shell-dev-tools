#!/bin/bash

function set_up() {
  ROOT_DIR="$(dirname "${BASH_SOURCE[0]}")/.."
  source "$ROOT_DIR/src/unix.sh"
}

test_unix_now() {
  assert_matches "[0-9]{10,}" $(unix_now)
}

test_unix_to_date() {
  assert_equals "Sat Sep 13 21:34:38 UTC 2025" "$(unix_to_date 1757799278)"
}
