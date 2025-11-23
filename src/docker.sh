dockerll() {
  docker ps -a --format "table {{ .Names }}\t{{ .Status }}\t{{ .Networks }}\t{{ .Ports }}" $@
}

try_docker() {
  local docker_run="docker run"
  local help="\nusage\t\ttry_docker <container_name> <image> [command]\n\ndefault entrypoint is /bin/bash:\n$docker_run -it --rm --name <container_name> --entrypoint=<entrypoint> <image> <command>"
  if [[ $1 == '-h' || $1 == '--help' ]]; then
    echo -e $help
    return 0
  fi
  if [[ $# < 2 ]]; then
    echo -e "\n\terror: too few arguments \n\n$help"
    return 1
  fi
  container_name=$1
  image=$2
  entrypoint=${3:-/bin/bash}
  command="${@:4}"
  echo "$docker_run -it --rm --name $container_name --entrypoint=$entrypoint $image $command"
  if [[ "$UNIT_TESTING" == "true" ]]; then
    detach="-d" # testing: no interactive tty
  else
    it="-it" # the dev wants to immediately discover the container
    rm="--rm"
  fi
  docker run $detach $it $rm --name $container_name --entrypoint=$entrypoint $image $command
}
