
local RSA = require('src.lib.rsa')

local function printBinary(b)
	local numberPrecision = 32
	local out = ''
	for i = numberPrecision, 1, -1 do
		local bi = bit32.btest(1,bit32.rshift(b,i-1))
		if(bi==true)then
			out = out..1
		else
			out = out .. 0
		end
	end
	print(out)
end

printBinary(1)

local function test(a,b,n,answer)
	local b = RSA.modular_exponentiation(a,b,n)
	assert(b==answer,'modular_exp algorithm has a bug in the results for '..a..'^'..b..'mod'..n..' ~= '..answer)
	print( b )
end

test(7,560,561,1)
test(11,13,53,52)
test(91,12,99,64)
test(3453,345,745,343)

