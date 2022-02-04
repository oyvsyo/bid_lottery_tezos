### Maximim Bid Lottery

Smart contract on Tezos blockchain implementing lottery with following rules:  
 - there are 5 players in round (5 allocated places)
 - players have to send amount > 1tz to the contract
 - player who sent the maximum ammout is winner
 - the prize is all money sent - 1tz is sent to the winner
 - 1tz commision is sent to the owner of contract

P.S. The game is obvious because all data on blockchain is open and you can see other players transactions, so there is bad decision to send less, so the last player will win if all players have this information.   
The game was created for learning purpose and deployed on testnet. Its not recommended to deploy it on real network.

