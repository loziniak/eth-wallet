Red [
	Title:	"bip39"
	Author: "bitbegin"
	File: 	%bip39.red
	Tabs: 	4
	License: "BSD-3 - https://github.com/red/red/blob/master/BSD-3-License.txt"
]

#system [
	#include %bip39.reds
	t: Mnemonic/new Type24Words "123456"
	dump-memory as byte-ptr! t/string 1 16
]

bip39: context [


]