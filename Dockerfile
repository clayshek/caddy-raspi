FROM arm32v6/alpine

LABEL maintainer="clay@clayshekleton.com"

# Install required packages
RUN apk add --update --no-cache curl
RUN apk add --update --no-cache bash
RUN apk add --update --no-cache libcap
RUN apk add --update --no-cache git

# Install latest version of Caddy, personal License, with GIT & Prometheus plugins
RUN curl https://getcaddy.com | bash -s personal http.git,http.prometheus

# Create caddy user acct, enable port binding <1024
RUN adduser -Du 1000 caddy
RUN setcap cap_net_bind_service=+ep $(which caddy)

RUN mkdir -p /var/www/caddy
RUN chown -R caddy:caddy /var/www/caddy
RUN chmod -R 755 /var/www/caddy

RUN mkdir /etc/caddy
ADD ./Caddyfile /etc/caddy/Caddyfile

WORKDIR /home/caddy
USER caddy
ENTRYPOINT ["/usr/local/bin/caddy"]
CMD ["-conf", "/etc/caddy/Caddyfile"]
EXPOSE 80
