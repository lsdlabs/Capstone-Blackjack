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
    
//    func winner()->String{
//        if player.blackjack && !house.blackjack{
//            return "player"
//        }
//        if !player.blackjack && house.blackjack{
//            return "house"
//        }
//        if player.busted{
//            return "house"
//        }
//        if house.busted{
//            return "player"
//        }
//        if player.cards.count == 9 && !player.busted { //changed from 5 to 9
//            return "player"
//        }
//        if house.stayed && player.stayed{
//            if player.handScore > house.handScore{
//                return "player"
//            } else {
//                return "house"
//            }
//        }
//        ///////
//        if !player.busted && player.handScore > house.handScore {
//            return "player"
//        }
//        if !house.busted && house.handScore > player.handScore {
//            return "house"
//        }
//        if player.handScore == house.handScore {
//            return "draw"
//        }
//        ///////
//        return "no"
//    }
    
//    func winner() ->String {
//        if player.blackjack && house.blackjack {
//            return "draw"
//        } else if player.blackjack && !house.blackjack {
//            return "player"
//        } else if !player.blackjack && house.blackjack {
//            return "house"
//        } else if player.busted && house.busted {
//            return "draw"
//        } else if player.busted && !house.busted {
//            return "house"
//        } else if !player.busted && house.busted {
//            return "player"
//        } else if player.cards.count == 9 && !player.busted {
//            return "player"
//        } else if house.stayed && player.stayed && player.handScore == house.handScore{
//                return "draw"
//        } else if house.stayed && player.stayed && player.busted && house.busted {
//            return "draw"
//        } else if  house.stayed && player.stayed && player.handScore > house.handScore {
//                return "player"
//        } else if  house.stayed && player.stayed && house.handScore > player.handScore{
//                return "house"
////            else if house.stayed && player.stayed {
////                if player.handScore == house.handScore {
////                    return "draw"
////                } else if player.handScore > house.handScore {
////                    return "player"
////                } else {
////                    return "house"
////                }
//        } else if !player.busted && !house.busted && player.handScore > house.handScore {
//            return "player"
//        } else if !player.busted && house.busted {
//            return "player"
//        } else if !house.busted && !player.busted && house.handScore > player.handScore {
//            return "house"
//        } else if !house.busted && player.busted {
//            return "house"
//        } else if player.handScore == house.handScore {
//            return "draw"
//        }
//        return "no"
//    }
//
////} else if !player.busted && player.handScore > house.handScore {
////    return "player"
////} else if !house.busted && house.handScore > player.handScore {
////    return "house"
////} else if player.handScore == house.handScore {
////    return "draw"
////}
////return "no"
//
    
    
    func winner() ->String {
        var result = ""
        result = determineBlackjack()
        result = determineDraw()
        result = determineIfPlayerIsTheWinner()
        result = determineIfDealerIsTheWinner()
        
        return result
    }
    
    
    
    func determineBlackjack()-> String{
        if player.blackjack && !house.blackjack {
            return "Congrats! You Won!"
        } else if !player.blackjack && house.blackjack {
            return "The House Won0"
        }
        else {
            return "No Blackjack"
        }
    }
    
    
    func determineDraw()-> String {
        if player.blackjack && house.blackjack {
            return "It's A Draw"
        }
        return "Not a Draw"
    }
    
    
    func determineIfPlayerIsTheWinner()-> String{
        if !player.busted && house.busted {
            return "Congrats! You Won!"
        } else if house.stayed && player.stayed && player.handScore > house.handScore {
            return "Congrats! You Won!"
        } else if !player.busted && !house.busted && player.handScore > house.handScore {
            return "Congrats! You Won!"//might not need this
        }
        return "The Player Did Not Win"
    }
    
    func determineIfDealerIsTheWinner()-> String{
        if player.busted && house.busted {
            return "The House Won1"
        } else if player.busted && !house.busted {
            return "Busted! The House Won2"
        } else if house.stayed && player.stayed && player.handScore == house.handScore{
            return "The House Won3"
        } else if house.stayed && player.stayed && player.busted && house.busted {
            return "The House Won4"//might nt need this
        } else if  house.stayed && player.stayed && house.handScore > player.handScore{
            return "The House Won5"
        } else if !house.busted && !player.busted && house.handScore > player.handScore {
            return "The House Won6"
        } //else if player.handScore == house.handScore {
          //  return "The House Won7"
        //}
        return "The House Did Not Win"
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



