-- Adds quicksort to the lua stdlib table library

require 'src.util'

local function Partition(A, p, r)
	local x = A[r]
	local i = p - 1
	for j = p, (r-1) do
		if A[j] <= x then
			i = i + 1
			table.exchange(A, i, j)
		end
	end
	table.exchange(A, i+1, r)
	return i+1
end

local function QuickSort(A, p, r)
	if p < r then
		local q = Partition(A, p, r)
		QuickSort(A, p, q-1)
		QuickSort(A, q+1,r)
	end
end

table.quicksort = function(A, p, r)
	assert(type(A)=='table',"Quicksort must be called on a table")
	QuickSort(A, p or 1, r or #A)
end

