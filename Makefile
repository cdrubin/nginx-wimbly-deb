
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



gcc-required: ; @which gcc > /dev/null
build:			gcc-required
	# copy in the pre-configured luarocks
	cp INCLUDE/luarocks-wimbly-$(LUAROCKS_VERSION).tar.gz BUILD

	# open and rename openresty
	cd BUILD && tar -xzf ngx_openresty-$(NGINX_VERSION).tar.gz
	mv BUILD/ngx_openresty-$(NGINX_VERSION) BUILD/nginx-wimbly-$(NGINX_VERSION)

	# move luarocks into position
	cd BUILD && tar -xzf luarocks-wimbly-$(LUAROCKS_VERSION).tar.gz
	mv BUILD/luarocks-wimbly-$(LUAROCKS_VERSION) BUILD/nginx-wimbly-$(NGINX_VERSION)/bundle


clean:
	rm -r BUILD/*
