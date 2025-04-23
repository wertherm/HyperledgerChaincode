# 🔗 Chaincode Go Boilerplate - Hyperledger Fabric

Este é um projeto **boilerplate de Chaincode em Go**, desenvolvido para aplicações com **Hyperledger Fabric**. Ele serve como ponto de partida para soluções blockchain empresariais, com uma estrutura limpa, modular e de fácil expansão.

---

## Tecnologias Utilizadas

- **Go (Golang)** — Linguagem principal para o chaincode
- **Hyperledger Fabric** — Framework blockchain permissionado
- **Docker Compose** — Orquestração de containers para ambiente Dev
- **Fabric Contract API Go** — SDK oficial da Hyperledger para desenvolvimento de smart contracts

---

## Estrutura do Projeto

```bash
HyperledgerChaincode/
├── chaincode/
│   ├── chaincode.go    # chaincode principal deste exemplo
│   ├── main.go         # Entry point do chaincode
│   ├── contract.go     # Lógica principal do contrato
│   └── utils.go        # Funções auxiliares
├── deploy_chancode.sh  # Script de deploy da rede
├── invoke_set.sh       # Script set do chaincode
├── query_get.sh        # Script get do chaincode
├── go.mod              # Módulo Go com dependências
└── docker-compose.yaml # Ambiente Dev com Fabric Peer
```

## Scripts
Antes de executar revise o documento `Deploy.md` <br>

`deploy_chaincode.sh`
1. Atualize os caminhos:
    - `ORDERER_CA` e `PEER_CA` com os caminhos corretos para os certificados da sua rede.
    - `CC_PATH` com o caminho do seu projeto Go.
2. Dê permissão de execução:
    - `chmod +x deploy_chaincode.sh`
3. Execute o script:
    - `./deploy_chaincode.sh`

---

`invoke_set.sh` e `query_get.sh`
1. Atualize os caminhos:
    - `ORDERER_CA` e `PEER_CA` com os caminhos corretos para os certificados da sua rede.
2. Dê permissão de execução:
    - `chmod +x invoke_set.sh query_get.sh`
3. Execute o script:
    - `./invoke_set.sh produto123 "Cadeira Gamer"`
    - `./query_get.sh produto123`