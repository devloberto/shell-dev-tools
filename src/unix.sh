unix_now() {
  date +%s
}

unix_to_date() {
  date -d @$1
}
