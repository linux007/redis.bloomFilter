-- bit = require('bit')
local entries = 10000000
local error_chance = 0.0001
local bits = nil
local hashs = 0
local offset = 0
local exist = true

local function FNVHash(str)
	local hash = 2166136261;  -- 32位offset basis  
	local prime = 16777619;   -- 32位prime

	for w in string.gmatch(str, "%g+") do
		hash = bit.bxor(hash, string.byte( w ))
		hash = hash * prime
		hash = hash * 4294967296
	end
	return hash
end

bits = -(entries * math.log( error_chance )) /math.pow(math.log(2), 2)
hashs = math.floor(math.log(2) * ( bits / entries))

-- local str = 'lua'
local str =  ARGV[1]
local fnv = FNVHash(str)
for i = 1, hashs do
	offset = math.floor((fnv + (fnv * i)) % bits)
	-- print( offset )
	if redis.call('GETBIT', str, offset) == 0 then
		exist = false
		break
	end
end

if exist then
	return 1
end

return 0

