### Maximum Bid Lottery

Smart contract on Tezos blockchain implementing lottery with following rules:  
 - there are `5` players in the round (`5` allocated places)
 - players have to send amount > `1tz` to the contract (forming the bank)
 - the player who sent the maximum amount is a winner
 - the prize is all money sent except commission (`bank - 1tz`) is sent to the winner
 - `1tz` commission is sent to the owner of the contract

View contract at [better-call.dev](https://better-call.dev/hangzhou2net/KT1NftWVsX3E4HQPp1WL1Ct1VQmT5z32k4Lh)

P.S. The game is obvious because all data on a blockchain is open and you can see other players' transactions, so there is a bad decision to send less, so the last player will win if all players have this information.   
The game was created for learning purpose and deployed on testnet. Its not recommended to deploy it on the real network.



