
# try to include configuration for ./configure if it was run
-include INCLUDE/VARS

.PHONY: all downloads clean

# Check all values that are required to be in CONFIG
# or passed on command line.
ifndef NGINX_VERSION
	$(error Makefile requires NGINX_VERSION to be set in INCLUDE/VARS)
endif

ifndef LUAROCKS_VERSION
	$(error Makefile requires LUAROCKS_VERSION to be set in INCLUDE/VARS)
endif




# The rule to make everything
all:			download build


curl-required: ; @which curl > /dev/null
download:		curl-required
	@echo
	@echo "- download openresty $(NGINX_VERSION)"
	@cd BUILD && curl -O --progress-bar https://openresty.org/download/ngx_openresty-$(NGINX_VERSION).tar.gz
	@echo



devscripts-required: ; @which debuild > /dev/null
build:			devscripts-required
	# copy in the pre-configured luarocks
	cp INCLUDE/luarocks-wimbly-$(LUAROCKS_VERSION).tar.gz BUILD

	# open and rename openresty
	cd BUILD && tar -xzf ngx_openresty-$(NGINX_VERSION).tar.gz
	mv BUILD/ngx_openresty-$(NGINX_VERSION) BUILD/nginx-wimbly-$(NGINX_VERSION)

	# move luarocks into position
	cd BUILD && tar -xzf luarocks-wimbly-$(LUAROCKS_VERSION).tar.gz
	mv BUILD/luarocks-wimbly-$(LUAROCKS_VERSION) BUILD/nginx-wimbly-$(NGINX_VERSION)/bundle

	# copy config files into nginx conf directory
	cp INCLUDE/nginx.base.config BUILD/nginx-wimbly-$(NGINX_VERSION)/bundle/nginx-*/nginx.conf
	cp INCLUDE/wimbly_cors.config BUILD/nginx-wimbly-$(NGINX_VERSION)/bundle/nginx-*/wimbly_cors.conf
	cp INCLUDE/wimbly_cors_options.config BUILD/nginx-wimbly-$(NGINX_VERSION)/bundle/nginx-*/wimbly_cors_options.conf
	cp INCLUDE/init.lua.config BUILD/nginx-wimbly-$(NGINX_VERSION)/bundle/nginx-*/init.lua

	# insert install commands into the package
	sed -i -e '/install resty/r INCLUDE/openresty_configure.insert' BUILD/nginx-wimbly-$(NGINX_VERSION)/configure

	# repackage
	cd BUILD && tar -czf nginx-wimbly_$(NGINX_VERSION).orig.tar.gz nginx-wimbly-$(NGINX_VERSION)
	rm BUILD/ngx_openresty-$(NGINX_VERSION).tar.gz

	# copy in the deb boiler-plate files
	cp -r INCLUDE/debian BUILD/nginx-wimbly-$(NGINX_VERSION)

	# build the deb
	cd BUILD/nginx-wimbly-$(NGINX_VERSION) && dch --create -v $(NGINX_VERSION) --package nginx-wimbly && debuild -us -uc

clean:
	rm -r BUILD/*
