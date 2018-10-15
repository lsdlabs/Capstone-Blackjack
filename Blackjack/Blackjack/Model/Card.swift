//
//  Card.swift
//  Blackjack
//
//  Created by Lauren Small on 10/8/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import Foundation

class Card{
    let suit: String
    let rank: String //hierarchy/position/order
    //rename cardLabel to cardType???
    //var cardLabel: String = ""
    private var cardLabel = "" //had to change because it complained about self in init()
    //var cardValue: Int = 0
    //private(set) var cardValue: Int = 0 //had to change because it complained about self in init()
     var cardValue: Int = 0 
//    var description: String {
//        get{
//            return cardLabel
//        }
    var description: String { //? or the one above
        return cardLabel
    }
    
    init(withSuit suit: String, withRank rank: String){
        self.suit = suit
        self.rank = rank
        self.cardLabel = "\(suit)\(rank)"
        self.cardValue = getCardValue(with: rank)
    }
    
    ///The getCardValue method takes in a String parameter and 
    private func getCardValue(with rank: String)-> Int{
        switch rank{
        case "A":
            return 1
        case "2", "3", "4", "5", "6", "7", "8", "9", "10":
            return Int(rank)!
        case "J", "Q", "K":
            return 10
        default:
            return 0
        }
    }
    
    //legitimate/acceptable/valid
    //func or class func?
    
    class func legitimateSuits()-> [String] {
        return ["Spades", "Hearts", "Diamonds", "Clubs"]
    }
//    func legitimateSuits()-> [String] {
//        return ["Spades", "Hearts", "Diamonds", "Clubs"]
//    }
//    func legitimateSuits()-> [String] {
//        return ["♠️", "♥️", "♦️", "♣️"]
//    }
    
//    func legitimateRanks()-> [String] {
//        return ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
//    }
    class func legitimateRanks()-> [String] {
        return ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
}
}

//description/representatio/rendition/illustration/portrayal
func descriptionFor(cardArray: [Card]) -> String {
    var description = "\(cardArray.count)"
    var count = 0
    for eachCard in cardArray{
        if count % 13 == 0 {
            description += "\n "
        }
        description += " \(eachCard.description)"
        count += 1
    }
    return description
}


