#!/bin/bash

# Variáveis personalizáveis
CC_NAME="meu-chaincode"
CC_LABEL="meu-chaincode_v1"
CC_VERSION="1.0"
CC_SEQUENCE=1
CC_PATH="github.com/seuprojeto/meu-chaincode"
CHANNEL_NAME="mychannel"
ORDERER_HOST="localhost:7050"
ORDERER_CA="/path/para/orderer/ca.crt"
PEER_ADDRESS="localhost:7051"
PEER_CA="/path/para/peer0.org1/ca.crt"

# Empacotar o chaincode
echo "📦 Empacotando o chaincode..."
peer lifecycle chaincode package ${CC_NAME}.tar.gz \
  --path ${CC_PATH} \
  --lang golang \
  --label ${CC_LABEL}

# Instalar o chaincode
echo "📥 Instalando o chaincode no peer..."
peer lifecycle chaincode install ${CC_NAME}.tar.gz

# Obter Package ID
PACKAGE_ID=$(peer lifecycle chaincode queryinstalled | grep "${CC_LABEL}" | awk -F "Package ID: " '{print $2}' | awk -F ", Label:" '{print $1}')
echo "📦 Package ID: $PACKAGE_ID"

# Aprovar o chaincode para a organização
echo "✅ Aprovando o chaincode..."
peer lifecycle chaincode approveformyorg \
  --channelID ${CHANNEL_NAME} \
  --name ${CC_NAME} \
  --version ${CC_VERSION} \
  --package-id ${PACKAGE_ID} \
  --sequence ${CC_SEQUENCE} \
  --init-required \
  --orderer ${ORDERER_HOST} \
  --tls \
  --cafile ${ORDERER_CA}

# Verificar prontidão do commit
echo "🔍 Verificando se o chaincode está pronto para commit..."
peer lifecycle chaincode checkcommitreadiness \
  --channelID ${CHANNEL_NAME} \
  --name ${CC_NAME} \
  --version ${CC_VERSION} \
  --sequence ${CC_SEQUENCE} \
  --init-required \
  --output json

# Comitar o chaincode
echo "📢 Comitando o chaincode..."
peer lifecycle chaincode commit \
  --channelID ${CHANNEL_NAME} \
  --name ${CC_NAME} \
  --version ${CC_VERSION} \
  --sequence ${CC_SEQUENCE} \
  --init-required \
  --orderer ${ORDERER_HOST} \
  --tls \
  --cafile ${ORDERER_CA} \
  --peerAddresses ${PEER_ADDRESS} \
  --tlsRootCertFiles ${PEER_CA}

# Invocar o Init
echo "🚀 Inicializando o chaincode..."
peer chaincode invoke \
  -o ${ORDERER_HOST} \
  --isInit \
  --tls \
  --cafile ${ORDERER_CA} \
  -C ${CHANNEL_NAME} \
  -n ${CC_NAME} \
  --peerAddresses ${PEER_ADDRESS} \
  --tlsRootCertFiles ${PEER_CA} \
  -c '{"Args":[]}'