ARG SOURCE_IMAGE
FROM $SOURCE_IMAGE

RUN yum install -y tar gzip zip libicu krb5-libs openssl-libs && \
  yum clean all && \
  rm -rf /var/cache/yum && \
  curl -fsSL https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh && \
  chmod +x dotnet-install.sh && \
  ./dotnet-install.sh -c 3.1 && \
  rm -f dotnet-install.sh

ENV DOTNET_CLI_TELEMETRY_OPTOUT 1
ENV DOTNET_ROOT /root/.dotnet
ENV PATH $DOTNET_ROOT:$DOTNET_ROOT/tools:$PATH