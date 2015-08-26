###### QNIBTerminal images
FROM qnib/consul

RUN yum install -y bsdtar cmake make golang git-core patch
RUN echo 3;git clone -b snappy https://github.com/qnib/heka.git /opt/heka-dev/
RUN cd /opt/heka-dev/ && \
    sh build.sh 
RUN mkdir -p /usr/share/heka && \
    mv /opt/heka-dev/dasher /usr/share/heka/ && \
    mv /opt/heka-dev/build/heka /opt/
RUN echo "/opt/heka/bin/hekad -config=/etc/heka/hekad.toml" >> /root/.bash_history && \
    yum install -y nmap nc
ADD /etc/heka/*.toml /etc/heka/
ADD etc/consul.d/heka.json /etc/consul.d/
ADD etc/supervisord.d/heka.ini /etc/supervisord.d/
