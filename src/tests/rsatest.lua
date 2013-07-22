
local RSA = require('src.lib.rsa')



print("-- Begin RSA Test --")

print('first some modular exponentiation tests:')

local function mod_test(a,b,n,answer)
	local b = RSA.modular_exponentiation(a,b,n)
	assert(b==answer,'modular_exp algorithm has a bug in the results for '..a..'^'..b..'mod'..n..' ~= '..answer)
	print( b )
end

mod_test(7,560,561,1)
mod_test(11,13,53,52)
mod_test(91,12,99,64)
mod_test(3453,345,745,343)

print '\nnow some witness tests:'
local testnums = {101,125589,12083571,7583,3457,2345,1234567,98429348923,123516161,3453577,3452345234987,34528823493,1233333333,2341233997,3429857209348457,234523462346287,277776476575677,35672304201,12341251611,12311112394881,111123123171111171109}
for i = 1, #testnums do
	--print(RSA.witness(0,testnums[i]))
end

print '\nNow some prime testing'
for i = 1, #testnums do
	print('is '..testnums[i]..' prime? '..(RSA.miller_rabin(testnums[i])and'yes' or 'no'))
end

print("-- End RSA Test --")


