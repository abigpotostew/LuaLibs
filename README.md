#LuaLibs #
##By Stewart Bracken ##
###stewart.bracken.bz ###

This is an assortment of common algorithms implemented in Lua v5.2 created while reading through Introduction to Algorithms Third Edition by Cormen, Leiserson, Rivest, and Stein.

These algorithms work just fine, but I created them as an educational excersize for myself. There's probably an identical set of more polished and optimized algorithms somewhere out. Just FYI!

##DEPENDENCIES: ##
lbc - For arbitrary precision numbers (large primes)
	http://www.tecgraf.puc-rio.br/~lhf/ftp/lua/#lbc
	  

##NOTES: ##
These two numbers combines took 331.63 seconds to compute using algorithms in my rsa lua implementation.
Since Miller-rabin is a randomized test, this speed varies a bit. 
Here's the estimated speeds I've found while running my code:
Digits	Time Range (s)		Avg		Growth
16		[0.01 - 0.1]		.055	0
32		[0.1 - 1.0]			.55		10
64		[ 2.0 - 5.0 ]		3.5		6.363636364
256		[333.63 - 478.84]	405		115.714285714

That's like exponential growth from 64 -> 256. Sounds about right! My code couldn't be optimized more. TODO!

#####256-digit primes: #####

* 129428250590256999493139025059634793814932235027569090340634564790755330541182964049737920036071393266642972113715699161163168385278092083193182953617107884858187294087952973847925947017060149720834897355569923744752000391836255326584133841976507358312011
* 6082414969998233288662581500552835252813020262674907972397380297005252342852662210367464038692878669285177169303508932543961844777887393277261600413658062121098161588356915228486509219837257791261150781985462960129567146004268475614201111227833175407801741
* 6006404162176493574578866022097784341534782880690145416615682899268529230698120209559040579401384236899874309689912712498917186779892780193989982128563761756459265040845710742580966037002456555563260061338770028993322502148360316929267246394190999643603717
* 1890268875942266829594071396062927780645705055178403097815590727891704089025032013490942506591699752900206268288310186099164259761212784021904342700350132332561006600230699923488953882512303396260076581986264983117182965555379131890219080400095214323038583```