ARG SOURCE_IMAGE
FROM $SOURCE_IMAGE

RUN curl -fsSL https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh && \
  chmod +x dotnet-install.sh && \
  ./dotnet-install.sh -c 3.1 && \
  rm -f dotnet-install.sh

ENV DOTNET_ROOT /root/.dotnet
ENV PATH $DOTNET_ROOT:$PATH
