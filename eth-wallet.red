Red [
	Title:	"eth-wallet"
	Author: "bitbegin"
	File: 	%eth-wallet.red
	Tabs: 	4
	License: "BSD-3 - https://github.com/red/red/blob/master/BSD-3-License.txt"
]

#include %bip32.red
#include %rlp.red

eth-wallet: context [

	private-key: none
	seeds: none

	; set the bip32 path of the wallet
	; type: block!
	; e.g [8000002Ch 8000003Ch 80000000h 0 idx]
	bip32-path: [8000002Ch 8000003Ch 80000000h 0]		;-- default: ETH coin, account 0, change 0

	init: func [
		"create the master private key"
		seed		[block! none!]		;-- 24-word seed, if none, create a random one
		password	[string!]
		return:		[block!]			;-- return [words entropy seed]
	][
		seeds: either seed [
			Mnemonic/from-words seed password
		][
			Mnemonic/new 'Type24Words password
		]
		seeds/1
	]

	get-address: func [
		idx			[integer! none!]
		return:		[string!]
	][
		bip32key/pubkey-to-address get-public idx
	]

	; tx: [
	; 	nonce		[integer!]
	; 	gas-price	[binary!]
	; 	gas-limit	[integer!]
	; 	to-address	[binary!]
	; 	amount		[binary!]			;-- Wei
	; 	data		[binary!]
	; ]
	sign-transaction: func [
		idx			[integer! none!]
		tx			[block!]
		chain-id	[integer!]
		return:		[binary!]
		/local key raw hash sig
	][
		key: either integer? idx [get-private idx][private-key]
		append tx reduce [chain-id 0 0]
		raw: rlp/encode tx
		hash: secp256/sha3-256 raw
		sig: secp256/sign hash key
		poke tx 7 chain-id * 2 + 35 + sig/1
		poke tx 8 sig/2
		poke tx 9 sig/3
		rlp/encode tx
	]

	get-public: func [
		idx			[integer! none!]
		return:		[binary!]
		/local path xpub
	][
		either idx = none [
			path: copy bip32-path
		][
			path: append copy bip32-path idx
		]
		xpub: bip32key/derive seeds/3 path false
		xpub/6
	]

	get-private: func [
		idx			[integer! none!]
		return:		[binary!]
		/local path xprv
	][
		either idx = none [
			path: copy bip32-path
		][
			path: append copy bip32-path idx
		]
		xprv: bip32key/derive seeds/3 path true
		xprv/6
	]
]
