-- rsa.lua

require 'src.util'


local RSA = {}
--First some math functions

local numberPrecision = 32

-- Fast results using repeated squaring technique
-- tested with answers from http://www.mathcelebrity.com/modexp.php
RSA.modular_exponentiation = function(a,b,n)
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

RSA.witness = function(a, n)
	if n%2 == 0 then return false end --primes can't be even
	local u = n-1
	local t = 0
	for i = 1, 32 do
		t = t+1
		u = bit32.rshift(u,1)
		if bit32.btest(1,u) then break end
	end
	
	local x_prev = RSA.modular_exponentiation(a,u,n)
	for i = 1, t do
		local xi = x_prev^2 % n
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
RSA.miller_rabin = function(n,s)
	s = s or 100
	for j = 1, s do
		local a = math.random(n-1)
		if RSA.witness(a,n) then
			return false --composite
		end
	end
	return true --prime
end

--string.byte(s, i) returns number at index i of string s

return RSA