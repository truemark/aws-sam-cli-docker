FROM amazon/aws-cli:latest as base

RUN yum install -y curl bash make unzip jq git gnupg && \
    curl -sSLf https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip -o aws-sam-cli-linux-x86_64.zip && \
    unzip aws-sam-cli-linux-x86_64.zip -d sam-installation && \
    ./sam-installation/install && \
    rm -rf sam-installation aws-sam-cli-linux-x86_64.zip && \
    yum clean all && \
    rm -rf /var/cache/yum
COPY helper.sh /helper.sh
ENTRYPOINT ["/usr/local/bin/sam"]
