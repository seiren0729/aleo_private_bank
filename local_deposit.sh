#!/bin/bash
ALEO_ADDRESS=$1

leo run deposit "{
  owner: "${ALEO_ADDRESS}".private,
  amount: 100u64.private,
  _nonce: 7968522480765950328355377838261428409240539265886056487261410805598260411495group.public
}" 30u64