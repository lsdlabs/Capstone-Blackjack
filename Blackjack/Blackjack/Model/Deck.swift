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
    
    var summary: String{
        return self.getSummary()
    }
    
    init(){
        var cards: [Card] = []
        for suit in Card.legitimateSuits(){ //In Card class, I had to change func legitimateSuits to class func legitimateSuits
            for rank in Card.legitimateRanks(){ //In Card class, I had to change func legitimateRanks to class func legitimateRanks
                let card = Card(withSuit: suit, withRank: rank)
                cards.append(card)
            }
        }
        undealtCards = cards
        dealtCards = []
    }
    
    
    //getSummary() or getDescription()
    private func getSummary()-> String{
        var summary = "Deck\n Cards Left: " + descriptionFor(cardArray: undealtCards)
        summary += "\n Cards Dealt: " + descriptionFor(cardArray: dealtCards)
        
        return summary
    }
    
    func drawCard()-> Card{
        let card = undealtCards.removeLast()
        self.dealtCards.append(card)
        return card
    }
    
    
    
}
