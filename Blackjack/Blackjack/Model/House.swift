//
//  House.swift
//  Blackjack
//
//  Created by Lauren Small on 10/9/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import Foundation

class House: Player{
    var mustHit: Bool{
        return handScore < 17
    }
    
    override init(name: String) {
        super.init(name: name)
        money = 1000
    }
}
