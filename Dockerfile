FROM python:3.9-alpine as base
RUN apk update && \
    apk --no-cache upgrade && \
    apk add --no-cache bash make && \
    apk add --no-cache --virtual build-deps build-base gcc && \
    pip install --no-cache-dir aws-sam-cli && \
    apk del build-deps
ENTRYPOINT ["/usr/local/bin/sam"]

FROM base as golang
COPY --from=golang:alpine /usr/local/go/ /usr/local/go/
ENV GOROOT /usr/local/go
ENV GOPATH /go
ENV PATH $GOROOT/bin:/go/bin:$PATH
