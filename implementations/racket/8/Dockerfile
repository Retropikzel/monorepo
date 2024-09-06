# -*- mode: dockerfile; coding: utf-8 -*-
FROM debian:bookworm-slim
RUN apt-get update && apt-get -y --no-install-recommends install \
      libedit2 racket ca-certificates \
 && rm -rf /var/lib/apt/lists/*
COPY scheme-script /usr/local/bin/
COPY scheme-r7rs /usr/local/bin/
RUN raco pkg install --no-docs --auto r7rs
RUN ln -s /usr/bin/racket /usr/local/bin/scheme-banner
CMD ["scheme-banner"]
