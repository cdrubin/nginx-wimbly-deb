
If ever needed, creating a luarocks-wimbly archive is achieved by pre-configuring and building a luarocks archive with :

  ./configure --prefix=/var/lib/nginx/luajit --with-lua=/var/lib/nginx/luajit --lua-suffix=jit --with-lua-include=/var/lib/nginx/luajit/include/luajit-2.1
  make build

on a machine that already has nginx-wimbly installed. Then tar up the directory.
