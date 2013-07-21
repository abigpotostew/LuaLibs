--heap entry point
require("mobdebug").start()

local Heap = require 'lib.heap'
require('lib.quicksort')

local heapLength = 10
local datamax = {}
local datamin = {}
local quicksortData = {}
for i = 1, heapLength do
	datamax[i]=i
	datamin[i]=heapLength-(i-1) --go down to 1
	quicksortData[i] = heapLength-(i-1)
end

local maxHeap = Heap.new(true, datamax)
local minHeap = Heap.new(false, datamin)


maxHeap:buildMaxHeap()

minHeap:buildMinHeap()

assert(maxHeap:left(1)==2,'left funciton is wrong!')
assert(maxHeap:right(1)==3,'right funciton is wrong!')
assert(maxHeap:parent(2)==1,'parent funciton is wrong!')

print('before heapsort')

maxHeap:heapsort()
minHeap:heapsort()

table.quicksort(quicksortData)

os.exit()