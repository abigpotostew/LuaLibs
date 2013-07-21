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