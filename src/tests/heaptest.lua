-- Heap test

local Heap = require 'src.lib.heap'


print("-- Begin Heap Test --")


local heapLength = 10
local datamax = {}
local datamin = {}

for i = 1, heapLength do
	datamax[i]=i
	datamin[i]=heapLength-(i-1) --go down to 1
end

local maxHeap = Heap.new(true, datamax)
local minHeap = Heap.new(false, datamin)

table.print(maxHeap,'initial maxHeap')
maxHeap:buildMaxHeap()
table.print(maxHeap,'maxHeap after heapifying')

assert(maxHeap:left(1)==2,'left funciton is wrong!')
assert(maxHeap:right(1)==3,'right funciton is wrong!')
assert(maxHeap:parent(2)==1,'parent funciton is wrong!')

table.print(maxHeap,'maxHeap after sorting')
maxHeap:heapsort()


table.print(minHeap,'minHeap before sorting')
minHeap:buildMinHeap()
table.print(maxHeap,'minHeap after heapifying')
minHeap:heapsort()
table.print(maxHeap,'minHeap after sorting')

print("-- End Heap Test --")
