FROM python:3.9-slim-buster as base
RUN apt-get -qq update && apt-get -qq upgrade --no-install-recommends && \
    apt-get -qq install curl bash make build-essential --no-install-recommends && \
    pip install --no-cache-dir aws-sam-cli && \
    apt-get -qq remove build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["/usr/local/bin/sam"]

FROM base as golang
COPY --from=golang:buster /usr/local/go/ /usr/local/go/
ENV GOROOT /usr/local/go
ENV GOPATH /go
ENV PATH $GOROOT/bin:/go/bin:$PATH

FROM base as node-14
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && \
  apt-get -qq install nodejs && \
  apt-get clean && rm -rf /var/lib/apt/lists/*
