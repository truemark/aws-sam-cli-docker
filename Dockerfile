FROM python:3.9-slim-buster as base
RUN apt-get -qq update && apt-get -qq upgrade --no-install-recommends && \
    apt-get -qq install curl bash make build-essential unzip --no-install-recommends && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip && \
    pip install --no-cache-dir aws-sam-cli && \
    apt-get -qq remove build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
COPY helper.sh /helper.sh
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
