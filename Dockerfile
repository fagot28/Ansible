FROM nginx:1.19.4

LABEL maintainer="fadeev@Technocom.tech"

COPY files/nginx/modules/ngx_http_vhost_traffic_status_module.so /etc/nginx/modules 
