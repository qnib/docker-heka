###### QNIBTerminal images
FROM qnib/consul

ENV HEKA_VER 0.10.0b1
RUN curl -fsL https://github.com/mozilla-services/heka/releases/download/v${HEKA_VER}/heka-$(echo ${HEKA_VER}|sed -e 's/\./_/g')-linux-amd64.tar.gz |tar xzf - -C /opt/ && \
    mv /opt/heka-$(echo ${HEKA_VER}|sed -e 's/\./_/g')-linux-amd64 /opt/heka/
RUN mv /opt/heka/share/heka /usr/share/heka
RUN echo "/opt/heka/bin/hekad -config=/etc/heka/hekad.toml" >> /root/.bash_history && \
    yum install -y nmap nc net-tools
ADD /etc/heka/*.toml /etc/heka/
ADD etc/consul.d/*.json /etc/consul.d/
ADD etc/supervisord.d/heka.ini /etc/supervisord.d/
ADD opt/qnib/heka/bin/kafka_connections.sh /opt/qnib/heka/bin/
