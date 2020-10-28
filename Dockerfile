FROM python:3.8-alpine
RUN apk update && \
    apk --no-cache upgrade && \
    apk add bash && \
    apk add --no-cache --virtual build-deps build-base gcc && \
    pip install --no-cache-dir aws-sam-cli && \
    apk del build-deps
ENTRYPOINT ["/usr/local/bin/sam"]
