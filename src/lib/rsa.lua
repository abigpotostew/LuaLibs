-- rsa.lua

require 'src.util'
if bc==nil then
	bc = require 'bc'
end


local RSA = {}
--First some math functions

local numberPrecision = 32

-- powmod(a,b,n) == a^b%n
-- Fast results using repeated squaring technique
-- tested with answers from http://www.mathcelebrity.com/modexp.php
-- NOTE: for use with Lua Numbers. Not compatible with bc nums
RSA.powmod = function(a,b,n)
	local d = 1
	for i = numberPrecision, 1, -1 do
		d = (d*d)%n
		local bi = bit32.btest(1,bit32.rshift(b,i-1))
		if(bi==true)then
			d = (d*a)%n
		end
	end
	return d
end

RSA.witness_num = function(a, n)
	if n%2==0 and n~=2 then return true end --primes can't be even
	local u = n-1
	local t = 0
	for i = 1, 32 do
		t = t+1
		u = bit32.rshift(u,1)
		if bit32.btest(1,u) then break end
	end
	local x_prev = RSA.powmod(a,u,n)
	for i = 1, t do
		local xi = RSA.powmod(x_prev,2,n) --x_prev^2 % n 
		if (xi == 1) and (x_prev ~= 1) and (x_prev ~= n-1) then
			return true --if non trivial squareroot of 1 is found..
		end
		x_prev = xi
	end
	if x_prev ~= 1 then
		return true
	end
	return false
end

-- Determines if n is prime (true) or composite(false)
-- s is an optional parameter for number of trials to
-- test n. More trials means the primality of n is more
-- reliable if the function returns true.
RSA.miller_rabin_num = function(n,s)
	s = s or 3
	for j = 1, s do
		local a = math.random(n-1)
		if RSA.witness_num(a,n) then
			return false --composite
		end
	end
	return true --prime
end

--Witnes where both arguments are bc numbers
RSA.witness_bc = function(a,n)
	if n%2 == 0 and n~=2 then return true end --primes can't be even
	local u = n-1 --u is even now
	local t = bc.number(0)
	local one, two = bc.number(1), bc.number(2)
	for i = 1, bc.bitlength(u) do
		t = t+1
		u = u/2 --right bit shift
		if u%2==one then break end --if last bit is a 1 (odd)
	end
	local x_prev = bc.powmod(a,u,n)
	for i = 1, bc.tonumber(t) do
		local xi = bc.powmod(x_prev,two,n)
		if (xi==one) and (x_prev~=one) and (x_prev ~= n-1) then
			return true
		end
		x_prev = xi
	end
	if x_prev ~= one then return true end
	return false
end

--n is a bc number, s is a lua number
RSA.miller_rabin_bc = function(n,s)
	s = s or 3
	for j = 1, s do
		local a = bc.random(n-1)
		if RSA.witness_bc(a,n) then
			return false --composite
		end
	end
	return true --prime
end

RSA.is_prime = function(n)
	if type(n)=='number' then return RSA.miller_rabin_num(n) 
	else return RSA.miller_rabin_bc(n) end
end

return RSA