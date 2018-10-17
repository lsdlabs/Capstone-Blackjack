//
//  Dealer.swift
//  Blackjack
//
//  Created by Lauren Small on 10/9/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import Foundation

class Dealer{
    let deck = Deck()
    let house = House(name: "House")
    let player = House(name: "Player")
    var bet: Int = 0
    
    
    func placeBet(bet: Int)-> Bool{
        if house.canPlaceABet(of: bet) && player.canPlaceABet(of: bet){
            self.bet = bet
            return true
        } else {
            self.bet = 0
            return false
        }
    }
    
    func deal(){
        deck.shuffle()
        player.cards.removeAll()
        house.cards.removeAll()
        player.stayed = false
        house.stayed = false
        
        
        for index in 0...1{
            player.cards.append(deck.drawCard())
            house.cards.append(deck.drawCard())
        }
    }
    
    func turn(house: House){
        if house.mayHit{
            print("\(house.name)'s turn:")
            if house.mustHit {
                house.cards.append(deck.drawCard())
                print("\(house.name) hits!")
                print(house)
            } else {
                house.stayed = true
                print("\(house.name) stays!")
            }
        }
    }
    
    func winner()->String{
        if player.blackjack && !house.blackjack{
            return "player"
        }
        if !player.blackjack && house.blackjack{
            return "house"
        }
        if player.busted{
            return "house"
        }
        if house.busted{
            return "player"
        }
        if player.cards.count == 5 && !player.busted {
            return "player"
        }
        if house.stayed && player.stayed{
            if player.handScore > house.handScore{
                return "player"
            } else {
                return "house"
            }
        }
        ///////
        if !player.busted && player.handScore > house.handScore {
            return "player"
        }
        if !house.busted && house.handScore > player.handScore {
            return "house"
        }
        if player.handScore == house.handScore {
            return "draw"
        }
        ///////
        return "no"
    }
    
    func award()-> String{
        let winner = self.winner()
        switch winner{
        case "house":
            house.didWinAmount(of: bet)
            return "House wins \(bet)!"
        case "player":
            house.didLoseAmount(of: bet)
            player.didWinAmount(of: bet)
            return "Player wins \(bet)!"
        case "no":
            return "There is no winner yet."
        default:
            return "Error award: \(winner)"
        }
    }
    
}



