FROM debian:buster-slim

RUN apt-get update && \
    apt-get install -y curl \
                       gnupg && \
    echo "deb [arch=amd64] http://repo.powerdns.com/debian buster-auth-44 main" > /etc/apt/sources.list.d/pdns.list && \
    curl https://repo.powerdns.com/FD380FBB-pub.asc | apt-key add - && \
    apt-get update && \
    apt-get install -y pdns-server \
                       pdns-backend-mysql && \
    mkdir /var/run/pdns && \
    chown -R pdns:pdns /var/run/pdns \
             /etc/powerdns/               

USER pdns

EXPOSE 53/tcp 53/udp                       

ENTRYPOINT [ "/usr/sbin/pdns_server" ]
CMD [ "--daemon=no", "--guardian=no", "--loglevel=9" ]