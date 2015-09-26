#! /bin/sh

. ./INCLUDE/VARS

cd BUILD

tar -xzvf ngx_openresty-$NGINX_VERSION.tar.gz
mv ngx_openresty-$NGINX_VERSION nginx-wimbly-$RESTY_VERSION
tar -xzvf luarocks-wimbly-$LUAROCKS_VERSION.tar.gz
mv luarocks-wimbly-$LUAROCKS_VERSION nginx-benchmark-$RESTY_VERSION/bundle
