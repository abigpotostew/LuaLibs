
local RSA = require('src.lib.rsa')
if bc==nil then
	bc = require 'bc'
end
print("-- Begin RSA Test --")

print('first some modular exponentiation tests:')

local function mod_test(a,b,n,answer)
	local b = RSA.powmod(a,b,n)
	assert(b==answer,'modular_exp algorithm has a bug in the results for '..a..'^'..b..'mod'..n..' ~= '..answer)
	print( b )
end

mod_test(7,560,561,1)
mod_test(11,13,53,52)
mod_test(91,12,99,64)
mod_test(3453,345,745,343)

print '\nnow some witness tests:'
local testnums = {561,101,11,13,17,1123110,112310}
local bc_testnums = {}

for i = 1, #testnums do
	--print(RSA.witness_num(0,testnums[i]))
	bc_testnums[i] = bc.number(testnums[i])
	--print(RSA.witness_bc(0))
end

print('bitlength 1=',bc.bitlength(bc.number(1)))
print('bitlength 2=',bc.bitlength(bc.number(2)))
print('bitlength 4=',bc.bitlength(bc.number(4)))
print('bitlength 8=',bc.bitlength(bc.number(8)))

print '\nNow some prime testing'
for i = 1, #testnums do
	--bc_testnums[i] = bc.number(testnums[i])
	print('NUM is '..testnums[i]..' prime? ','NUM='..(RSA.is_prime(testnums[i])and'yes' or 'no'),
	'BC='..(RSA.is_prime(bc_testnums[i])and'yes' or 'no'))
end




local bigprimes = {}
while #bigprimes < 2 do
	local n = math.random(2^32-1)--bc.random_digit(encryption_strength,encryption_strength)
	if n%2==0 then n = n-1 end
	if RSA.is_prime(n) then
		print('PRIME!!',n)
		--if RSA.is_prime(n) then 
			table.insert(bigprimes,n) 
			--end
	end
end
print('***** Number Primes found:')
for i=1,#bigprimes do
	print(i,bigprimes[i])
end

local function find_prime()
	local digits = encryption_strength
	while true do
		local n = bc.random_digit(digits,digits)
		if n%2==0 then n = n-1 end --make it odd
		if RSA.is_prime(n) then
			return n
		end
		coroutine.yield()
	end
end

local encryption_strength = 8
local num_primes = 2
local co = {}
for i=1,num_primes do 
	co[i]=coroutine.create(function() find_prime() end)
end

bigprimes={}
while #bigprimes < num_primes do
	for i=1,#co do
		if coroutine.status(co[i])~='dead' then
			local s, prime = coroutine.resume(co[i])
			if s == false then print(s,prime) table.insert(bigprimes,prime) end
		end
	end
end
print('***** BC Primes found:')
for i=1,#bigprimes do
	print(i,bigprimes[i],'\n')
end

print("-- End RSA Test --")


