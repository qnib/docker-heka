###### QNIBTerminal images
FROM qnib/consul

ENV HEKA_VER 0.10.0b1
RUN curl -fsL https://github.com/mozilla-services/heka/releases/download/v${HEKA_VER}/heka-$(echo ${HEKA_VER}|sed -e 's/\./_/g')-linux-amd64.tar.gz |tar xzf - -C /opt/ && \
    mv /opt/heka-$(echo ${HEKA_VER}|sed -e 's/\./_/g')-linux-amd64 /opt/heka/
RUN mv /opt/heka/share/heka /usr/share/heka
ADD /etc/hekad.toml /etc/
ADD etc/rsyslog.d/file.conf /etc/rsyslog.d/
