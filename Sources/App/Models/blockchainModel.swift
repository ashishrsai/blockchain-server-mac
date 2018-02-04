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
        self.blockchain = blockChain(genesis: blockchainBlock())
    }
    
    func startBlockchain() -> blockChain{
        return self.blockchain
    }
    //we can use this function to mine a block
    func mineablock(transactions : [transaction]) -> blockchainBlock{
        let tempBlock = self.blockchain.addNewBlock(transactionInBlock : transactions)
        self.blockchain.appendBlockToBlockChain(block: tempBlock)
        return tempBlock
    }
}
