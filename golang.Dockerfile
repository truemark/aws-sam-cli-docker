ARG SOURCE_IMAGE
FROM $SOURCE_IMAGE
COPY --from=golang:buster /usr/local/go/ /usr/local/go/
ENV GOROOT /usr/local/go
ENV GOPATH /go
ENV PATH $GOROOT/bin:/go/bin:$PATH
