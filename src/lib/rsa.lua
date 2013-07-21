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
	local u = n-1
	local t = 0
	while bit32.btest(1,bit32.rshift(u,t)) do
		t = t+1
	end
	
	
end

--string.byte(s, i) returns number at index i of string s

return RSA