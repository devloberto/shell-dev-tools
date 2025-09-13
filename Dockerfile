FROM debian:13.1

ENV bashunit_dir='/typeddevs'
ENV bashunit_version='0.23.0'
ENV bashunit_hash='7043c1818016f330ee12671a233f89906f0d373f3b2aa231a8c40123be5a222b'

# bashunit installation dependencies
RUN apt-get update; apt-get install -y curl perl git; rm -rf /var/lib/apt/lists/*

RUN mkdir -p $bashunit_dir
RUN curl -o /tmp/install.sh https://bashunit.typeddevs.com/install.sh
RUN bash /tmp/install.sh $bashunit_dir $bashunit_version; ln -s $bashunit_dir/bashunit /usr/bin/bashunit; chmod +x $bashunit_dir/bashunit

# verify the sha256sum for bashunit 0.14.0
RUN DIR="$bashunit_dir"; KNOWN_HASH="$bashunit_hash"; FILE="$DIR/bashunit"; [ "$(shasum -a 256 "$FILE" | awk '{ print $1 }')" = "$KNOWN_HASH" ] && echo -e "✓ \033[1mbashunit\033[0m verified." || { echo -e "✗ \033[1mbashunit\033[0m corrupt"; rm "$FILE"; }

RUN bashunit --version

RUN groupadd -g 1000 dev && useradd -m -u 1000 -g dev dev

WORKDIR /home/dev/shell-dev-tools

RUN --mount=type=bind,source=bashrc,target=/tmp/bashrc \
  cat /tmp/bashrc >> /root/.bashrc && \
  cat /tmp/bashrc >> /home/dev/.bashrc

USER dev

RUN git config --global init.defaultBranch master && \
  git config --global user.email "shell@dev.tools" && \
  git config --global user.name "dev"

ENTRYPOINT ["/bin/bash"]

