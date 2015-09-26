#! /bin/sh

. ./INCLUDE/VARS

cd BUILD

echo "get dat openresty friend..."
curl -O --progress-bar https://openresty.org/download/ngx_openresty-$NGINX_VERSION.tar.gz

