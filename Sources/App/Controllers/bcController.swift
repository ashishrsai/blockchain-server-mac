//
//  bcController.swift
//  App
//
//  Created by Ashutosh Kumar sai on 03/02/18.
//

import Foundation
import Vapor
import HTTP

class bcController {
    var drop :Droplet
    var blockchainmodel :blockchainModel
    init(drop :Droplet) {
        self.drop = drop
        self.blockchainmodel = blockchainModel()
        self.routes()
    }
    
    func routes(){
        self.drop.post("miner") { request in
            
            if let transactions = transaction(request: request ){
              let tempBlock = self.blockchainmodel.mineablock(transactions: [transactions])
                return try JSONEncoder().encode(tempBlock)
            }
            return "error"
        }
        self.drop.get("BlockChain"){ request in
            let blockchain = self.blockchainmodel.startBlockchain()
            return try! JSONEncoder().encode(blockchain)
        }
    }
}
