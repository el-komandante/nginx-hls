FROM ubuntu:18.04
WORKDIR /nginx
RUN apt-get update
RUN apt-get update && apt-get install -y git \
  build-essential \
  libpcre3 \
  libpcre3-dev \
  libssl-dev \
  zlib1g \
  zlib1g-dev \
  wget
RUN git clone https://github.com/sergey-dryabzhinsky/nginx-rtmp-module.git
RUN wget http://nginx.org/download/nginx-1.17.4.tar.gz && tar -xf nginx-1.17.4.tar.gz
RUN cd nginx-1.17.4 && \
  ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module && make && make install
RUN rm /usr/local/nginx/conf/nginx.conf
COPY nginx.conf /usr/local/nginx/conf/nginx.conf
EXPOSE 80
CMD /usr/local/nginx/sbin/nginx -g 'daemon off;'
