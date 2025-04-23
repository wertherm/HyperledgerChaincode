#!/bin/bash

# Variáveis
CC_NAME="meu-chaincode"
CHANNEL_NAME="mychannel"
ORDERER_HOST="localhost:7050"
ORDERER_CA="/path/para/orderer/ca.crt"
PEER_ADDRESS="localhost:7051"
PEER_CA="/path/para/peer0.org1/ca.crt"

# Argumentos
CHAVE=$1
VALOR=$2

if [ -z "$CHAVE" ] || [ -z "$VALOR" ]; then
  echo "❌ Uso: ./invoke_set.sh <chave> <valor>"
  exit 1
fi

# Invocar a função "set"
echo "📨 Gravando $CHAVE = $VALOR no ledger..."
peer chaincode invoke \
  -o ${ORDERER_HOST} \
  --tls \
  --cafile ${ORDERER_CA} \
  -C ${CHANNEL_NAME} \
  -n ${CC_NAME} \
  --peerAddresses ${PEER_ADDRESS} \
  --tlsRootCertFiles ${PEER_CA} \
  -c '{"Args":["set","'"$CHAVE"'","'"$VALOR"'"]}'