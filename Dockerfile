FROM dokken/centos-stream-9

RUN dnf -y update && \
    dnf -y install nginx

COPY ./index.html /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
