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
    
    init(drop :Droplet) {
        self.drop = drop
        routes()
    }
    
    func routes(){
        self.drop.get("hello"){ request in
            return "it is working"
        }
    }
}
