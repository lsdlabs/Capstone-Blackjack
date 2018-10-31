//
//  Tokens.swift
//  Blackjack
//
//  Created by Lauren Small on 10/31/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import Foundation


class Tokens: NSObject, Codable {
    var playerTokens: Int
    
    init(playerTokens: Int){
        self.playerTokens = playerTokens
    }
}
