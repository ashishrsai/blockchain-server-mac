//
//  blockchainModel.swift
//  App
//
//  Created by Ashutosh Kumar sai on 03/02/18.
//

import Foundation

class blockchainModel {
    
    var blockchain :blockChain!
    init() {
        self.blockchain = blockChain(genesis: blockchainBlock(),difficulty: "00")
    }
    
    func startBlockchain() -> blockChain{
        return self.blockchain
    }
    //we can use this function to mine a block
    func mineablock(transactions : [transaction]) -> blockchainBlock{
        return self.blockchain.addNewBlock(transactionInBlock : transactions)
    }
}
