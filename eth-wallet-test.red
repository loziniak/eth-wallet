Red [
	File: %eth-wallet-test.red
	Author: "bitbegin"
	Notes: {Primarily a part of %eth-wallet.red}
]

#include %eth-wallet.red

eth-wallet/init [abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about] "TREZOR"
;eth-wallet/bip32-path: [8000002Ch 8000003Ch 80000000h 0]

print "0x9c32F71D4DB8Fb9e1A58B0a80dF79935e7256FA6" == eth-wallet/get-address 0
print "0x7AF7283bd1462C3b957e8FAc28Dc19cBbF2FAdfe" == eth-wallet/get-address 1
print "0x05f48E30fCb69ADcd2A591Ebc7123be8BE72D7a1" == eth-wallet/get-address 2

print #{62f1d86b246c81bdd8f6c166d56896a4a5e1eddbcaebe06480e5c0bc74c28224} = eth-wallet/get-private 0
print #{49ee230b1605382ac1c40079191bca937fc30e8c2fa845b7de27a96ffcc4ddbf} = eth-wallet/get-private 1
print #{eef2c0702151930b84cffcaa642af58e692956314519114e78f3211a6465f28b} = eth-wallet/get-private 2

eth-wallet/private-key: #{4646464646464646464646464646464646464646464646464646464646464646}
data: reduce [9 #{04A817C800} 21000 #{3535353535353535353535353535353535353535} #{0DE0B6B3A7640000} #{}]
print #{f86c098504a817c800825208943535353535353535353535353535353535353535880de0b6b3a76400008025a028ef61340bd939bc2195fe537567866003e1a15d3c71ff63e1590620aa636276a067cbe9d8997f761aecb703304b3800ccf555c9f3dc64214b297fb1966a3b6d83}
= eth-wallet/sign-transaction none data 1
