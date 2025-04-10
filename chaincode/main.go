package main

import (
	"log"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

func main() {
	chaincode, err := contractapi.NewChaincode(&SmartContract{})
	if err != nil {
		log.Fatalf("Erro ao criar o chaincode: %v", err)
	}

	if err := chaincode.Start(); err != nil {
		log.Fatalf("Erro ao iniciar o chaincode: %v", err)
	}
}