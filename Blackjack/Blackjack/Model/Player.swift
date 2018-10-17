//
//  Player.swift
//  Blackjack
//
//  Created by Lauren Small on 10/8/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import Foundation

class Player{
    //a Player has a name, has cards, has money/tokens, can hit, can stay, can be busted, can place a bet, can win/lose
    
    let name: String
    var cards: [Card] = []
    var stayed: Bool = false
    var money: Int = 100
    
    var handScore: Int {
        return self.getHandScore()
    }
    var blackjack: Bool {
        return handScore == 21 && cards.count == 2
    }
    var busted: Bool {
        return handScore > 21
    }
    var mayHit: Bool {
        return !blackjack && !busted && !stayed
    }
    
    var description: String{
        return self.getStats()
    }
    
    ///////
    var cardsInHand: String{ return self.getCardsInHand()}
    ///////
    
    init(name: String){
        self.name = name
    }
    
    private func getStats()-> String{
        var stats = "Player: \(name)\n Cards In Hand: " + descriptionFor(cardArray: cards)
        stats += "\n handScore: \(handScore)\n blackjack: \(blackjack)\n busted: \(busted)"
        stats += "\n stayed: \(stayed)\n money: \(money)"
        return stats
    }
    
    ///////
    private func getCardsInHand()-> String {
        var cards = descriptionFor(cardArray: self.cards)
        return cards
    }
    ///////
    
    private func getHandScore()-> Int{
        var score: Int = 0
        
        for card in cards{
            score += card.cardValue
        }
        //need to check if the player has an ace
        if self.hasAce() && score <= 11{
            score += 10
        }
        return score
    }
    
    private func hasAce()->Bool{
        for card in cards{
            if card.rank == "A"{
                return true
            }
        }
        return false
    }
    
    func canPlaceABet(of bet: Int)-> Bool{
        return money >= bet
    }
    
    func didWinAmount(of bet: Int){
        money += bet
    }
    
    func didLoseAmount(of bet: Int){
        money -= bet
    }

    
}





