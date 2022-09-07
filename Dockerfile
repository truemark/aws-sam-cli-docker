FROM truemark/aws-cli:latest
COPY --from=truemark/git:amazonlinux-2 /usr/local/ /usr/local/
RUN yum install -q -y make unzip gnupg && \
    curl -sSLf https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip -o aws-sam-cli-linux-x86_64.zip && \
    unzip -q aws-sam-cli-linux-x86_64.zip -d sam-installation && \
    ./sam-installation/install && \
    rm -rf sam-installation aws-sam-cli-linux-x86_64.zip && \
    yum clean all && \
    rm -rf /var/cache/yum

