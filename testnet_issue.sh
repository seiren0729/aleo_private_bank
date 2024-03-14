ADDRESS=$1

APPNAME="bank_seiren"

ENV_FILE=".env"
PRIVATE_KEY=$(grep "PRIVATE_KEY" $ENV_FILE | cut -d '=' -f2)

cd .. && snarkos developer execute "${APPNAME}.aleo" "issue" "${ADDRESS}"  100u64 --private-key "${PRIVATE_KEY}" --query "https://api.explorer.aleo.org/v1" --broadcast "https://api.explorer.aleo.org/v1/testnet3/transaction/broadcast" --priority-fee 1000000  