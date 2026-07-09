SOURCE="${BASH_SOURCE[0]:-${(%):-%x}}" # bash and zsh compatability
SCRIPT_DIR="$(realpath -e -- "$(dirname -- "$SOURCE")")"

source "$SCRIPT_DIR/src/docker.sh"
source "$SCRIPT_DIR/src/git.sh"
source "$SCRIPT_DIR/src/strcnt.sh"
source "$SCRIPT_DIR/src/unix.sh"
