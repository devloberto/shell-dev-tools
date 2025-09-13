FROM debian:trixie-20240812

ENV bashunit_dir='/typeddevs'
ENV bashunit_version='0.14.0'
ENV bashunit_hash='84822a2f2d3a84646abad5fe26e6d49a952c6e5ea08e3752443d583346cc4d56'

# bashunit installation dependencies
RUN apt update; apt install -y curl perl git; rm -rf /var/lib/apt/lists/*

RUN mkdir -p $bashunit_dir
RUN curl -o /tmp/install.sh https://bashunit.typeddevs.com/install.sh
RUN bash /tmp/install.sh $bashunit_dir $bashunit_version; ln -s $bashunit_dir/bashunit /usr/bin/bashunit; chmod +x $bashunit_dir/bashunit

# verify the sha256sum for bashunit 0.14.0
RUN DIR="$bashunit_dir"; KNOWN_HASH="$bashunit_hash"; FILE="$DIR/bashunit"; [ "$(shasum -a 256 "$FILE" | awk '{ print $1 }')" = "$KNOWN_HASH" ] && echo -e "✓ \033[1mbashunit\033[0m verified." || { echo -e "✗ \033[1mbashunit\033[0m corrupt"; rm "$FILE"; }

RUN bashunit --version

RUN groupadd -g 1000 dev && useradd -m -u 1000 -g dev dev

WORKDIR /home/dev

RUN echo "alias ll='ls -halF --color'" >> /root/.bashrc
RUN echo "alias ll='ls -halF --color'" >> /home/dev/.bashrc

ENTRYPOINT ["/bin/bash"]

