package main

import (
	"encoding/json"
	"fmt"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

type SmartContract struct {
	contractapi.Contract
}

type Asset struct {
	ID    string `json:"ID"`
	Owner string `json:"Owner"`
	Value int    `json:"Value"`
}

func (s *SmartContract) InitLedger(ctx contractapi.TransactionContextInterface) error {
	return nil
}

func (s *SmartContract) CreateAsset(ctx contractapi.TransactionContextInterface, id string, owner string, value int) error {
	asset := Asset{ID: id, Owner: owner, Value: value}
	assetJSON, _ := json.Marshal(asset)
	return ctx.GetStub().PutState(id, assetJSON)
}

func (s *SmartContract) ReadAsset(ctx contractapi.TransactionContextInterface, id string) (*Asset, error) {
	assetJSON, err := ctx.GetStub().GetState(id)
	if err != nil || assetJSON == nil {
		return nil, fmt.Errorf("asset not found")
	}

	var asset Asset
	_ = json.Unmarshal(assetJSON, &asset)
	return &asset, nil
}

func main() {
	chaincode, err := contractapi.NewChaincode(new(SmartContract))
	if err != nil {
		panic("Error creating chaincode: " + err.Error())
	}

	if err := chaincode.Start(); err != nil {
		panic("Error starting chaincode: " + err.Error())
	}
}
