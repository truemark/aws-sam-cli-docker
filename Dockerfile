FROM truemark/aws-cli:amazonlinux-2023 as base
COPY --from=truemark/git:amazonlinux-2023 /usr/local/ /usr/local/
COPY --from=truemark/git-crypt:amazonlinux-2023 /usr/local/ /usr/local/
RUN yum install -q -y pip make gnupg && yum clean all && rm -rf /var/cache/yum && \
    pip install aws-sam-cli

FROM base AS node18
COPY --from=truemark/node:18-amazonlinux-2023 /usr/local /usr/local/
RUN npm install -g typescript aws-cdk pnpm yarn esbuild && \
    npm config set fund false --location=global

FROM base AS dotnet6
RUN yum install -y findutils tar gzip libicu && \
    curl -sSL https://dot.net/v1/dotnet-install.sh | bash -s -- -c 6.0 && \
    ln -s /root/.dotnet/dotnet /usr/local/bin/dotnet && \
    yum clean all && \
    dotnet tool install -g Amazon.Lambda.Tools
ENV DOTNET_ROOT="/root/.dotnet"
ENV PATH="/root/.dotnet:${PATH}"

FROM base AS dotnet7
RUN yum install -y findutils tar gzip libicu && \
    curl -sSL https://dot.net/v1/dotnet-install.sh | bash -s -- -c 7.0 && \
    ln -s /root/.dotnet/dotnet /usr/local/bin/dotnet && \
    yum clean all && \
    dotnet tool install -g Amazon.Lambda.Tools
ENV DOTNET_ROOT="/root/.dotnet"
ENV PATH="/root/.dotnet:${PATH}"

FROM base AS go
ARG TARGETARCH
RUN curl -sfSL "https://go.dev/dl/$(curl -sfSL 'https://go.dev/VERSION?m=text'| grep 'go').linux-${TARGETARCH}.tar.gz" -o go.tar.gz && \
    tar -C /usr/local -xzf go.tar.gz && \
    rm go.tar.gz
ENV GOROOT=/usr/local/go
ENV GOPATH=/go
ENV PATH=${GOROOT}/bin:/go/bin:${PATH}
