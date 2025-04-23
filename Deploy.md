# 🚀 Implementação Chaincode na Rede Hyperledger Fabric

Para implementar um chaincode na rede Hyperledger Fabric, siga este processo que inclui escrever, empacotar, instalar e aprovar o chaincode nos peers da rede.

---

## ✅ Pré-requisitos

Antes de começar, certifique-se de ter os seguintes itens prontos:

### 1. Ambiente de Desenvolvimento Go
- Go instalado e configurado corretamente.  
- Variáveis de ambiente `$GOPATH` e `$PATH` devidamente definidas.

### 2. Hyperledger Fabric Instalado
- Rede Hyperledger Fabric em execução (por exemplo, a `test-network`).  
- Binários da CLI (como `peer`, `orderer`, `configtxgen`) adicionados ao `$PATH`.

### 3. Docker
- Docker instalado e em execução (o chaincode será executado em contêineres Docker).

---

## 🛠️ Passos para Implementar o Chaincode

### 1. Criar a Estrutura do Projeto em Go

```bash
mkdir -p $GOPATH/src/github.com/seuprojeto
cd $GOPATH/src/github.com/seuprojeto
mkdir meu-chaincode
cd meu-chaincode
```

💡 Dica: Você pode criar o projeto fora do $GOPATH se estiver usando Go modules.

### 2. Chaincode desse exemplo: `chaincode\chaincode.go`

### 3. Empacotar o Chaincode

```bash
go mod init github.com/seuprojeto/meu-chaincode
go mod tidy
go build (opcional)
peer lifecycle chaincode package meu-chaincode.tar.gz \
  --path github.com/seuprojeto/meu-chaincode \
  --lang golang \
  --label meu-chaincode_v1
```
Isso ajuda a garantir que não haja erros de sintaxe.

### 4. Instalar o Chaincode
```bash
peer lifecycle chaincode install meu-chaincode.tar.gz
peer lifecycle chaincode queryinstalled
```
Copie o `Package ID` retornado — ele será necessário no próximo passo.

### 5. Aprovar o Chaincode para a Organização
Substitua `<PACKAGE_ID>` pelo valor copiado anteriormente:
```bash
peer lifecycle chaincode approveformyorg \
  --channelID mychannel \
  --name meu-chaincode \
  --version 1.0 \
  --package-id <PACKAGE_ID> \
  --sequence 1 \
  --init-required \
  --orderer localhost:7050 \
  --tls \
  --cafile $ORDERER_CA
```
📌 Use os parâmetros corretos de acordo com sua rede (canal, endereço do orderer, etc.).

### 6. Verificar o Status de Aprovação
```bash
peer lifecycle chaincode checkcommitreadiness \
  --channelID mychannel \
  --name meu-chaincode \
  --version 1.0 \
  --sequence 1 \
  --init-required \
  --output json
```

### 7. Commit do Chaincode
Depois que todas as organizações aprovarem:
```bash
peer lifecycle chaincode commit \
  --channelID mychannel \
  --name meu-chaincode \
  --version 1.0 \
  --sequence 1 \
  --init-required \
  --orderer localhost:7050 \
  --tls \
  --cafile $ORDERER_CA \
  --peerAddresses localhost:7051 \
  --tlsRootCertFiles $PEER0_ORG1_CA
```

### 8. Invocar o Método `Init`
Se o chaincode requer inicialização (`--init-required`):
```bash
peer chaincode invoke \
  -o localhost:7050 \
  --isInit \
  --tls \
  --cafile $ORDERER_CA \
  -C mychannel \
  -n meu-chaincode \
  --peerAddresses localhost:7051 \
  --tlsRootCertFiles $PEER0_ORG1_CA \
  -c '{"Args":[]}'
```

### 9. Invocar Funções (`set` e `get`)
```bash
# Gravar
peer chaincode invoke \
  -o localhost:7050 \
  --tls \
  --cafile $ORDERER_CA \
  -C mychannel \
  -n meu-chaincode \
  --peerAddresses localhost:7051 \
  --tlsRootCertFiles $PEER0_ORG1_CA \
  -c '{"Args":["set","chave","valor"]}'

# Consultar
peer chaincode query \
  -C mychannel \
  -n meu-chaincode \
  -c '{"Args":["get","chave"]}'
```