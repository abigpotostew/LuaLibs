-- quicksort test

--package.path = "../?.lua;" .. package.path

require('src.lib.quicksort')

print("-- Begin QuickSort Test --")

local count = math.random(25)

local quicksortData = {}
for i = 1, count do
	quicksortData[i] = math.random(100)
end

table.print(quicksortData, "before sorting")
table.quicksort(quicksortData)
table.print(quicksortData, "after sorting")

print("-- End QuickSort Test --")