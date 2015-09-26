#! /bin/sh

. ./INCLUDE/VARS

cd BUILD

cp ../INCLUDE/luarocks-wimbly-$LUAROCKS_VERSION.tar.gz .

tar -xzvf ngx_openresty-$NGINX_VERSION.tar.gz
mv ngx_openresty-$NGINX_VERSION nginx-wimbly-$NGINX_VERSION

tar -xzvf luarocks-wimbly-$LUAROCKS_VERSION.tar.gz
mv luarocks-wimbly-$LUAROCKS_VERSION nginx-wimbly-$NGINX_VERSION/bundle
