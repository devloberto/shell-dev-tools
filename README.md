# shell dev tools

handy tools for developers using bash or zsh

## installation

just clone the repository and source the `shell-dev-tools.sh` script in your `.bashrc`, `.zshrc` or whatever

## provided commands

### `git_delete_all_branches_but_default`

Delete all branches but the default branch. <br>
Supported default branch names:

* master
* main
* trunk
* stable
* mainline
* default

## development

* the tools are developed inside of a docker container
* all scripts are tested by [bashunit](https://github.com/TypedDevs/bashunit)

### setup to contribute

* clone the repository

    ```bash
    git clone ssh://gitea@yunohost.fritz.box:2217/flo_barth/shell-dev-tools.git
    cd shell-dev-tools
    ```

* build the docker image

    ```bash
    docker build -t shell-dev-tools:debian-trixie .
    ```
* run the container and enter its interactive shell

    ```bash
    docker run --rm -it --user dev --name shell-dev-tools shell-dev-tools:debian-trixie
      
    ```

## _TODO_

Test automation for zsh. <br>
Currently only bash support is automatically tested by bashunit.
zsh support is tested manually only at the moment. <br>
Maybe something like [shellspec](https://github.com/shellspec/shellspec) should be used which supports both bash and zsh.
