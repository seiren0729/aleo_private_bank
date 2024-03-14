ADDRESS=$1
APPNAME="bank_seiren"

ENV_FILE=".env"
PRIVATE_KEY=$(grep "PRIVATE_KEY" $ENV_FILE | cut -d '=' -f2)

RECORD="{
  owner: ${ADDRESS}.private,
  amount: 1001461u64.private,
  _nonce: 6641525579424018815978425256611702254159161538811580920184246328904479152161group.public
}"

cd .. && snarkos developer execute "${APPNAME}.aleo" "deposit" "${RECORD}"  30u64 --private-key "${PRIVATE_KEY}" --query "https://api.explorer.aleo.org/v1" --broadcast "https://api.explorer.aleo.org/v1/testnet3/transaction/broadcast" --priority-fee 1000000  