dockerll() {
  docker ps -a --format "table {{ .Names }}\t{{ .Status }}\t{{ .Networks }}\t{{ .Ports }}" $@
}
