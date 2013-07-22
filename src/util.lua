--utils


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