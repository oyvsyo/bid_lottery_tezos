// type declarations
type transaction = {
    user_address: address;
    amount: tez;
}

type storage = {
    bank: tez;
    n_filled: nat;
    users: transaction list;
}
type return = operation list * storage

// constants
let n_allocated : nat = 5n
let min_amount : tez = 1tez
let owner_commision: tez = min_amount

let ownerAddress : address =
  ("tz1MwT1z7i9DwNBXuHxhCTozKZGU64bYW8Cx" : address)

let owner_receiver : unit contract =
    match (Tezos.get_contract_opt ownerAddress  : unit contract option) with
    | Some (contract) -> contract
    | None -> (failwith ("Not a contract") : (unit contract))

let empty_t_list : transaction list = []
let empty_transaction : transaction = {
    user_address = ownerAddress;
    amount = 0tez;
}
let empty_storage: storage = {
    bank = 0tez;
    n_filled = 0n;
    users = empty_t_list;
}
// test constants
let test_transaction1 : transaction = {
    user_address = ownerAddress;
    amount = 1tez;
}
let test_transaction2 : transaction = {
    user_address = ownerAddress;
    amount = 2tez;
}
let test_storage : storage = {users = [test_transaction1]; n_filled = 1n; bank = 1tez}

// helper methods
let add_user (s, t : storage * transaction) : storage = {
    bank = s.bank + t.amount;
    n_filled = s.n_filled + 1n;
    users = t :: s.users
}
let find_largest_amount_transaction (accum, t: transaction * transaction) : transaction = 
  if t.amount > accum.amount then t else accum

let register_transaction (s, t : storage * transaction) : return = 
  ([] : operation list), add_user (s, t)

let make_winner (s, t : storage * transaction) : return = 
  let new_s : storage = add_user (s, t)
  in
  let winner : transaction = 
    List.fold find_largest_amount_transaction new_s.users empty_transaction
  in 
  let winner_reward : tez = new_s.bank - owner_commision
  in
  let winner_receiver : unit contract =
    match (Tezos.get_contract_opt winner.user_address  : unit contract option) with
    | Some (contract) -> contract
    | None -> (failwith ("Not a contract") : (unit contract))
  in
  let payout_winner_op : operation = 
    Tezos.transaction unit winner_reward winner_receiver
  in
  let payout_owner_op : operation = 
    Tezos.transaction unit owner_commision owner_receiver
  in
  let operations : operation list = 
    [payout_winner_op; payout_owner_op] 
  in
    ((operations: operation list), empty_storage)


// main function
let main (_p, s: unit * storage) : return  =
  let income : transaction = if (Tezos.amount < min_amount)  then
    failwith ("Less then minimum transaction") else {
      user_address = Tezos.source;
      amount = Tezos.amount;
  }
  in
  let res: return = if (s.n_filled + 1n = n_allocated) then make_winner (s, income) else register_transaction (s, income)
  in res
