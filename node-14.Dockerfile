ARG SOURCE_IMAGE
FROM $SOURCE_IMAGE
RUN curl -fsSL https://rpm.nodesource.com/setup_14.x | bash - && \
  yum install -y nodejs && \
  yum clean all && \
  rm -rf /var/cache/yum
