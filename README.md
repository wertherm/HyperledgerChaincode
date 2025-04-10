# 🔗 Chaincode Go Boilerplate - Hyperledger Fabric

Este é um projeto **boilerplate de Chaincode em Go**, desenvolvido para aplicações com **Hyperledger Fabric**. Ele serve como ponto de partida para soluções blockchain empresariais, com uma estrutura limpa, modular e de fácil expansão.

---

## Objetivos do Projeto

- Criar um modelo reutilizável de **Smart Contract em Go**
- Facilitar testes locais com **docker-compose** em modo Dev
- Fornecer um ponto de partida para projetos reais com **Hyperledger Fabric 2.x**

---

## Tecnologias Utilizadas

- **Go (Golang)** — Linguagem principal para o chaincode
- **Hyperledger Fabric** — Framework blockchain permissionado
- **Docker Compose** — Orquestração de containers para ambiente Dev
- **Fabric Contract API Go** — SDK oficial da Hyperledger para desenvolvimento de smart contracts

---

## Estrutura do Projeto

```bash
chaincode-go-boilerplate/
├── chaincode/
│   ├── main.go         # Entry point do chaincode
│   ├── contract.go     # Lógica principal do contrato
│   └── utils.go        # Funções auxiliares
├── go.mod              # Módulo Go com dependências
├── docker-compose.yaml # Ambiente Dev com Fabric Peer
└── README.md           # Este arquivo