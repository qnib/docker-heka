###### QNIBTerminal images
FROM qnib/consul

RUN yum install -y bsdtar cmake make golang git-core patch
RUN echo 2015-08-27.1;git clone -b 0.10-add-generic-json-decoder  https://github.com/nathwill/heka.git /opt/heka-dev/
RUN cd /opt/heka-dev/ && \
    sh build.sh 
RUN mkdir -p /usr/share/heka && \
    mv /opt/heka-dev/dasher /usr/share/heka/ && \
    mv /opt/heka-dev/build/heka /opt/
RUN echo "/opt/heka/bin/hekad -config=/etc/heka/hekad.toml" >> /root/.bash_history && \
    yum install -y nmap nc
ADD etc/consul.d/heka.json /etc/consul.d/
ADD etc/supervisord.d/heka.ini /etc/supervisord.d/
ADD /etc/heka/*.toml /etc/heka/
