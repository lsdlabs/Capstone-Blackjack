//
//  Deck.swift
//  Blackjack
//
//  Created by Lauren Small on 10/8/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import Foundation


class Deck{
    private var undealtCards: [Card]
    private var dealtCards: [Card]
    
    init(){
        var cards: [Card] = []
        for suit in Card.legitimateSuits(){ //had to change func legitimateSuits to class func legitimateSuits
            for rank in Card.legitimateRanks(){ //had to change func legitimateRanks to class func legitimateRanks
                let card = Card(withSuit: suit, withRank: rank)
                cards.append(card)
            }
        }
        undealtCards = cards
        dealtCards = []
    }
    
}
