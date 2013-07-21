-- Min or max heap
-- The heap is simply a table with all the data in the array 
-- section of the table. It also has heap functions attached
-- to the metatable, so all functions should be called using
-- the colon syntax on your heap.

-- TODO: implement a min / max priority queue

local Heap = {}

Heap.mt = {} --metatable

Heap.prototype = {}

Heap.mt.__index = Heap.prototype

function Heap.new(isMax,data)
	data = data or {}
	local heap = {}
	setmetatable(heap, Heap.mt)
	heap.isMax = isMax
	heap.heapsize = #data
	for i = 1, #data do
		heap[i] = data[i]
	end
	return heap
end

function Heap.prototype.parent(self,i)
	return math.max(1,math.floor(i/2)) --TODO right shift bit
	--return math.max(1,bit32.rshift(i,1))
end

function Heap.prototype.left(self,i)
	return math.max(1,2*i) --TODO: left shift the bits
	--return math.max(1,bit32.lshift(i,1))
end

function Heap.prototype.right(self,i)
	return math.max(1,2*i+1) --TODO: left shift the bits then add one
	--return math.max(1,bit32.lshift(i,1)+1)
end

function Heap.prototype.minHeapify(self,i)
	local l = self:left(i)
	local r = self:right(i)
	local smallest = nil
	if l <= self.heapsize and self[l] < self[i] then
		smallest = l
	else
		smallest = i
	end
	if r <= self.heapsize and self[r] < self[smallest] then
		smallest = r
	end
	if smallest ~= i then
		table.exchange(self,i,smallest)
		self.minHeapify(self,smallest)
	end
end

function Heap.prototype.buildMinHeap(self)
	self.isMax = false
	self.heapsize = #self
	for i = math.floor(#self), 1, -1 do
		self.minHeapify(self,i)
	end
end

function Heap.prototype.maxHeapify(self,i)
	local l = self:left(i)
	local r = self:right(i)
	local largest = nil
	if l <= self.heapsize and self[l] > self[i] then
		largest = l
	else
		largest = i
	end
	if r <= self.heapsize and self[r] > self[largest] then
		largest = r
	end
	if largest ~= i then
		table.exchange(self,i,largest)
		self.maxHeapify(self,largest)
	end
end

function Heap.prototype.buildMaxHeap(self)
	self.isMax = true
	self.heapsize = #self
	for i = math.floor(#self), 1, -1 do
		self.maxHeapify(self,i)
	end
end

function Heap.prototype.heapsort(self)
	local heapify = nil
	if self.isMax == true then
		heapify = self.maxHeapify
		self.buildMaxHeap(self)
	else
		heapify = self.minHeapify
		self.buildMinHeap(self)
	end
	for i = #self, 2, -1 do
		table.exchange(self,1,i)
		self.heapsize = self.heapsize-1
		heapify(self,1)
	end
end

return Heap