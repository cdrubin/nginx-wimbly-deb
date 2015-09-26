
-- # part of nginx-benchmark

-- part of openresty
cjson = require "cjson"


-- luarocks
require "luarocks.loader"



-- # luarocks installed libraries


-- uuid generator
uuid = require "uuid"
uuid.randomseed( os.time() * 10000 )


-- bcrypt password hasher
bcrypt = require "bcrypt"


-- date library
date = require "date"


-- native CSV Lua library
csv = require "csv"


-- for data structure inspection during development
inspect = require "inspect"


-- for light-weight classes
class = require "middleclass"




-- # wimbly libraries

-- wimbly included streaming XML parser
slaxml = require "wimbly/slaxml"


-- wimbly language and utility functions
require "wimbly/util"


-- wimbly form and field validation library
validate = require "wimbly/validate"


-- wimbly REST and http API helper
restfully = require "wimbly/restfully"


-- wimbly itself
wimbly = require "wimbly/wimbly"


local applications = wimbly.find( "/var/www", "init.wimbly$", { depth = 1 } )

-- application specific global-level initialization
for _, application in ipairs( applications ) do
  dofile( application )
end
