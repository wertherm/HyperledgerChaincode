package main

import (
    "fmt"

    "github.com/hyperledger/fabric-chaincode-go/shim"
    "github.com/hyperledger/fabric-protos-go/peer"
)

// SimpleAsset implementa um chaincode simples para gerenciar um ativo
type SimpleAsset struct{}

// Init é chamado durante a instância do chaincode para inicializar dados
func (t *SimpleAsset) Init(stub shim.ChaincodeStubInterface) peer.Response {
    fmt.Println("Chaincode Instanciado")
    return shim.Success(nil)
}

// Invoke é chamado para atualizar ou consultar o ledger
func (t *SimpleAsset) Invoke(stub shim.ChaincodeStubInterface) peer.Response {
    function, args := stub.GetFunctionAndParameters()
    if function == "set" {
        return t.set(stub, args)
    } else if function == "get" {
        return t.get(stub, args)
    }

    return shim.Error("Função inválida. Use 'set' ou 'get'")
}

func (t *SimpleAsset) set(stub shim.ChaincodeStubInterface, args []string) peer.Response {
    if len(args) != 2 {
        return shim.Error("Número incorreto de argumentos. Esperado: 2")
    }

    err := stub.PutState(args[0], []byte(args[1]))
    if err != nil {
        return shim.Error("Falha ao gravar estado")
    }

    return shim.Success(nil)
}

func (t *SimpleAsset) get(stub shim.ChaincodeStubInterface, args []string) peer.Response {
    if len(args) != 1 {
        return shim.Error("Número incorreto de argumentos. Esperado: 1")
    }

    value, err := stub.GetState(args[0])
    if err != nil || value == nil {
        return shim.Error("Falha ao recuperar valor")
    }

    return shim.Success(value)
}

func main() {
    err := shim.Start(new(SimpleAsset))
    if err != nil {
        fmt.Printf("Erro ao iniciar o chaincode: %s", err)
    }
}