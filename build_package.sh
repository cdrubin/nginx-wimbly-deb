#! /bin/sh

. ./INCLUDE/VARS

cd BUILD

tar -xzvf ngx_openresty-$RESTY_VERSION.tar.gz
mv ngx_openresty-$RESTY_VERSION nginx-wimbly-$RESTY_VERSION
tar -xzvf luarocks-wimbly-$LUAROCKS_VERSION.tar.gz
mv luarocks-wimbly-$LUAROCKS_VERSION nginx-benchmark-$RESTY_VERSION/bundle