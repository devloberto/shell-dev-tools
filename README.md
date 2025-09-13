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

* the tools are developed inside a docker container
* all scripts are tested by [bashunit](https://github.com/TypedDevs/bashunit)

### setup

* clone the repository

    ```bash
    git clone https://gitub.com/devloberto/shell-dev-tools.git
    cd shell-dev-tools
    ```

* build the docker image

    ```bash
    docker compose up -d --build
    ```

* interactively enter the container's shell for testing

    ```bash
    docker compose exec shell-dev-tools bash
    ```

    or directly run the unit tests

    ```bash
    docker compose exec shell-dev-tools bashunit
    ```

## _TODO_

Test automation for zsh. <br>
Currently only bash support is automatically tested by bashunit.
zsh support is tested manually only at the moment. <br>
Maybe something like [shellspec](https://github.com/shellspec/shellspec) should be used which supports both bash and zsh.
