//
//  model.swift
//  App
//
//  Created by Ashutosh Kumar sai on 03/02/18.
//

import Cocoa
//: Playground - noun: a place where people can play
// Building an outline for the actul blockchain server

//The blockchain is going to contain a class Trasaction which we will use in each block (Each block will contain multiple or single transction)
class transaction : Codable{
    //amount: this will denote the value of trasaction (this field can potentially be used for other applications as well)
    var amount :Double
    //to: will contain the address of the reciver , this will be the public key of the reciver
    var to :String
    //from: this will be the public key of the sender
    var from :String
    
    //initilaisation of the class
    init(amount :Double, to :String, from :String) {
        self.amount = amount
        self.to = to
        self.from = from
    }
    
}

// this class is a block in a blockchain. Our blockchain is going to contain a number of blocks
class blockchainBlock : Codable{
    //lasthash: this field is one of the most crucial field in the block, by using the previous hash we ensure that our blockchain is consistant (This is essentially a hash pointer )
    var lastHash :String = ""
    //index: we use index in order to identify the block number (The index 0 is our gensis block)
    var index :Int = 0
    //hash: we store the hash of our current block in this varibale
    var hash :String = "" //have to wirte the hash function to get this value
    //nonce: this is a value that starts with 0 (may change depending on the application) and is incresed gradually. (Used in Proof of Work)
    var nonce :Int
    //trasnctionInBlock: this is am array of tranaction in our block class (each block can contain multiple transction)
    var transactionInBlock :[transaction] = [transaction]()
    //initilaisation of the class
    init() {
        self.nonce = 0
    }
    
    // we use 4 main values to calculate hash - 1. Index , 2. Hash of previous block , 3. Nonce , 4. Our transction (This has to be in String) For our blockchain we take all these valeus in String
    var hashingValue :String{
        let transactionInJSON = try! JSONEncoder().encode(self.transactionInBlock)
        let transactionInString = String(data: transactionInJSON,encoding: .utf8)
        
        return String(self.index) + self.lastHash + String(self.nonce) + transactionInString!
    }
    
    func appendTransaction(transactionInBlock :transaction){
        self.transactionInBlock.append(transactionInBlock)
    }
    
}

//this class is the actual blockchain (This will consist of multiple blocks)
class blockChain : Codable{
    //blockInBlockChain is an array of object of class blockchainBlock (blockchain will have a number of blocks thus an array)
    var blockInBlockChain :[blockchainBlock] = [blockchainBlock]()
    var difficultylevel :String!
    
    init(genesis :blockchainBlock,difficulty :String) {
        self.appendBlockToBlockChain(block: genesis)
        difficultylevel = difficulty
    }
    
    func appendBlockToBlockChain(block :blockchainBlock){
        if (self.blockInBlockChain.isEmpty){
            print("The blockchain has no blocks so we will create a gennis block now")
            block.lastHash = "0000000000"
            block.hash = sha256Hash(block: block)
        }
        self.blockInBlockChain.append(block)
    }
    
    
    func sha256Hash(block :blockchainBlock) -> String{
        var finalHash = block.hashingValue.sha()
        //Proof of Work - Calculating hash with two zeros at the start
        while(!finalHash.hasPrefix("00")){
            block.nonce += 1
            finalHash = block.hashingValue.sha()
            print(finalHash)
        }
        return finalHash
    }
    //this function will add a new block to the blockchain
    func addNewBlock(transactionInBlock :[transaction]) -> blockchainBlock{
        let tempBlock = blockchainBlock()
        transactionInBlock.forEach { (transaction) in
            tempBlock.appendTransaction(transactionInBlock: transaction)
        }
        let lastBlock = self.blockInBlockChain[self.blockInBlockChain.count - 1]
        tempBlock.index = self.blockInBlockChain.count
        tempBlock.lastHash = lastBlock.hash
        tempBlock.hash = sha256Hash(block: tempBlock)
        return tempBlock
    }
    
}

// SHA256 Generator
// We can use this already written function that will generate SHA256 of a given string Credit: Stackoverflow
extension String {
    
    func sha() -> String {
        
        let task = Process()
        task.launchPath = "/usr/bin/shasum"
        task.arguments = []
        
        let inputPipe = Pipe()
        
        inputPipe.fileHandleForWriting.write(self.data(using: String.Encoding.utf8)!)
        
        inputPipe.fileHandleForWriting.closeFile()
        
        let outputPipe = Pipe()
        task.standardOutput = outputPipe
        task.standardInput = inputPipe
        task.launch()
        
        let data = outputPipe.fileHandleForReading.readDataToEndOfFile()
        let hash = String(data: data, encoding: String.Encoding.utf8)!
        return hash.replacingOccurrences(of: "  -\n", with: "")
    }
}

//Testing
//First block of the blockchain is always a genesis block
//Genesis block is just an instance of class blockchainBlock
let genesis = blockchainBlock()
let objBlockchain = blockChain(genesis: genesis,difficulty: "00")
let transactions = transaction(amount: 1000,to: "0xasbdklashg",from: "sadbjksadbcc09cs")
let newBlock = objBlockchain.addNewBlock(transactionInBlock : [transactions])
objBlockchain.appendBlockToBlockChain(block: newBlock)
print(objBlockchain.blockInBlockChain.count)

let JSONDATA = try! JSONEncoder().encode(objBlockchain)
let blockchainJSON = String(data: JSONDATA, encoding: .utf8)
print(blockchainJSON!)



