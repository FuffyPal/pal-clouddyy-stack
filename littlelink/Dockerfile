FROM nginx:alpine

WORKDIR /usr/share/nginx/html

RUN apk add --no-cache git

ARG repo=

RUN cd /root && \
    git clone ${repo} && \
    cp -r /root/littlelink/* /usr/share/nginx/html/ && \
    rm -rf /root/littlelink

WORKDIR /usr/share/nginx/html


RUN echo 'server { \
    listen 8080; \
    server_name localhost; \
    root /usr/share/nginx/html; \
    index index.html index.htm; \
    access_log /dev/stdout; \
    error_log /dev/stderr; \
    gzip on; \
    gzip_types text/plain text/css application/json application/javascript; \
    location ~* \.(?:css|js|jpg|jpeg|gif|png|ico|svg)$ { \
        expires 7d; \
        add_header Cache-Control "public"; \
    } \
}' > /etc/nginx/conf.d/default.conf

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]