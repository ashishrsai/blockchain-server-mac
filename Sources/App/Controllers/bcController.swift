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
        //Use this POST method in order to add a new node in the blockchain
        self.drop.post("addNode"){ request in
            if let nodes = node(request :request){
                self.blockchainmodel.addNewNode(nodes)
                
            }
            return try JSONEncoder().encode(["Did it work?":"Yes it did the node has been added"])
        }
        
        //Use this GET method to get a list of all the nodes in the blockchain
        self.drop.get("getnodes"){ request in
            return try JSONEncoder().encode(self.blockchainmodel.blockchain.nodes)
        }
    }
}
