#!/bin/bash

function set_up() {
  ROOT_DIR="$(dirname "${BASH_SOURCE[0]}")/.."
  source "$ROOT_DIR/src/strcnt.sh"
}

test_character_count() {
  # assert_equals "5" $(strcnt '#!§$@') @TODO: how to escape special chars?
  assert_equals "10" $(strcnt "#-!%&/()?@")
  assert_equals "30" $(strcnt "123456789 123456789 1234567890")
  assert_equals "50" $(strcnt "123456789 123456789 123456789 123456789 1234567890")
  assert_equals "70" $(strcnt "123456789 123456789 123456789 123456789 123456789 123456789 1234567890")
}
