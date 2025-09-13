SOURCE="${BASH_SOURCE[0]:-${(%):-%x}}" # bash and zsh compatability
SCRIPT_DIR="$(realpath -e -- "$(dirname -- "$SOURCE")")"

source "$SCRIPT_DIR/src/git_delete_all_branches_but_default.sh"
source "$SCRIPT_DIR/src/strcnt.sh"
source "$SCRIPT_DIR/src/unix.sh"
