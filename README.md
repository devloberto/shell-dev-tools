# shell tools

handy tools for developers using bash or zsh

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

