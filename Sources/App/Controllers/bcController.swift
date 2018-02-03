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
    var blockchain :blockchainModel
    init(drop :Droplet) {
        self.drop = drop
        self.blockchain = blockchainModel()
        self.routes()
    }
    
    func routes(){
        self.drop.get("hello"){ request in
            return "it is working"
        }
    }
}
