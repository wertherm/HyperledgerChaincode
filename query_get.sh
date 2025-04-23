#!/bin/bash

# Variáveis
CC_NAME="meu-chaincode"
CHANNEL_NAME="mychannel"
PEER_ADDRESS="localhost:7051"
PEER_CA="/path/para/peer0.org1/ca.crt"

# Argumento
CHAVE=$1

if [ -z "$CHAVE" ]; then
  echo "❌ Uso: ./query_get.sh <chave>"
  exit 1
fi

# Consultar a função "get"
echo "🔎 Buscando valor para chave '$CHAVE'..."
peer chaincode query \
  -C ${CHANNEL_NAME} \
  -n ${CC_NAME} \
  -c '{"Args":["get","'"$CHAVE"'"]}'