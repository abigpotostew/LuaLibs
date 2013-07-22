--utils

if bc==nil then
	bc = require 'bc'
end

math.randomseed(os.time())

table.exchange = function(t, a, b)
	local tmp = t[a]
	t[a] = t[b]
	t[b] = tmp
end


table.print = function(t,m)
	local out = (m and (m..': ') or '') .. (t[1] or '')
	for i = 2, #t do
		out = out .. ', ' .. t[i]
	end
	print(out)
end

printBinary = function(b)
	local numberPrecision = 32
	local out = ''
	for i = numberPrecision, 1, -1 do
		local bi = bit32.btest(1,bit32.rshift(b,i-1))
		if(bi==true)then
			out = out .. 1
		else
			out = out .. 0
		end
	end
	print(out)
end

bc.length = function(x)
	return #bc.tostring(x)
end

bc.string2bc = function(s)
	local x=bc.number(0)
    for i=1,#s do
    	x=256*x+s:byte(i)
    end
    return x
end

--s is a string with all numbers
bc.numstring2bc = function(s)
	local zero = ('0').byte(0)
	local x = bc.number(0)
	for i = 1, #s do
		x = x*10 + (s:byte(i)-zero)
	end
	return x
end

bc.bc2string = function(x)
	if x:iszero() then
		return ""
	else
		local r
		x,r=bc.divmod(x,256)
		return bc2string(x)..string.char(r:tonumber())
    end
end

--returns a random bc num with m digits
--if n is specified, returns a bc with random digits length in [m..n] range
bc.random_digit = function(m, n)
	assert(m,'bc.random(digits[,maxDigits])')
	local x = bc.number(0)
	local count = (n and math.random(m,n))
				  or m
				  print(count)
	for i = 1, count do
		local r = (math.random(10)-1)--[0..9]
		x = x*10 + r
	end
	return x
end

--returns a random bc num with m digits
--if n is specified, returns a bc with random digits length in [m..n] range
bc.random_digit = function(m, n)
	assert(m,'bc.random_digit(m[,n])')
	local x = bc.number(0)
	local count = (n and math.random(m,n)) or m
	for i = 1, count do
		local r = (math.random(10)-1)--[0..9]
		x = x*10 + r
	end
	return x
end

--m and n are bc numbers
--if n is nil, returns a bc number [1..m]
--if n is provided, returns a bc number [m..n]
bc.random = function(m, n)
	assert(m,'bc.random(m[,n])')
	local x = nil
	while true do
		if n then x = bc.random_digit(bc.length(m),bc.length(n))
		else x = bc.random_digit(1,bc.length(m)) end
		if n then
			if (x <= n and x >= m) then break end
		else
			if (x <= m) then break end
		end
	end
	if bc.iszero(x) then return bc.number(1)
	else return x end
end

--returns bitlength as if n were a single integer with arbitrary precision
bc.bitlength = function(n)
	local t = n
	local length = 0
	while bc.iszero(t) == false do
		t = t/2
		length = length + 1
	end
	return length
end