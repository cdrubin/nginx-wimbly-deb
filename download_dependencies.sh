#! /bin/sh

. ./VARS

echo "get dat openresty friend..."
curl -O --progress-bar https://openresty.org/download/ngx_openresty-$NGINX_VERSION.tar.gz

echo "and that laurockles pal..."
curl -O --progress-bar http://keplerproject.github.io/luarocks/releases/luarocks-$LUAROCKS_VERSION.tar.gz
