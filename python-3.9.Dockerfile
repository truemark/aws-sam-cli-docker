ARG SOURCE_IMAGE
FROM $SOURCE_IMAGE as pybuild
RUN yum install -q -y tar gzip gcc openssl-devel bzip2-devel libffi-devel && \
  curl -fsSL https://www.python.org/ftp/python/3.9.7/Python-3.9.7.tgz -o Python-3.9.7.tgz && \
  tar -zxf Python-3.9.7.tgz && \
  cd Python-3.9.7 && \
  ./configure --enable-optimizations && \
  make install && \
  yum clean all && \
  rm -rf /var/cache/yum

ARG SOURCE_IMAGE
FROM $SOURCE_IMAGE
COPY --from=pybuild /usr/local/lib/python3.9/ /usr/local/lib/python3.9/
COPY --from=pybuild /usr/local/include/python3.9/ /usr/local/include/python3.9/
COPY --from=pybuild /usr/local/include/python3.9/ /usr/local/include/python3.9/
COPY --from=pybuild /usr/local/bin/ /usr/local/bin/
