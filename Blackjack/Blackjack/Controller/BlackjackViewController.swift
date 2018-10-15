//
//  BlackjackViewController.swift
//  Blackjack
//
//  Created by Lauren Small on 10/10/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import UIKit

class BlackjackViewController: UIViewController {

    
    @IBOutlet weak var gameEventLabel: UILabel!
    @IBOutlet weak var playerCards: UILabel!
    @IBOutlet weak var dealerCards: UILabel!
    
    //1. initialise the deck
    let deck = Deck.init()
    let dealer = Dealer()
    
    
    var label = "" {
        didSet {
            gameEventLabel.text = "Score: \(label)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(deck.summary)//print the deck...make sure all the cards are there
                            //should print the cards remaining (52) and the number of cards dealt (0)
        //shuffle the deck, and print it to check
        showLabel()
        //gameEventLabel.text = "Welcome!"
//        if !gameEventLabel.isHidden {
//            gameEventLabel.isHidden = true
//            Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(showLabel), userInfo: nil, repeats: false)
//        }
        
        gameEventLabel.text = "Shuffling the deck..."
        deck.shuffle()
        print(deck.summary)
        
        let house = House.init(name: "House")
        
        house.cards.append(deck.drawCard())
        house.cards.append(deck.drawCard())
        print(house.description)
        
        dealerCards.text = "\(house.description)"//
        
        
        
        
        while house.mustHit{
            house.cards.append(deck.drawCard())
            house.cards.append(deck.drawCard())
            print(house.description)
        }
        
        while house.mustHit{
            house.cards.append(deck.drawCard())
            print(house.description)
        }
        
        self.playBlackjack(withBetOf: 20)
        
        
//        func playBlackjack(withBetOf bet: Int){
//            let goodBet = dealer.placeBet(bet: bet)
//            if !goodBet{
//                return
//            }
//            print("The bet is \(bet)")
//        }
        
        print("Deal!")
        dealer.deal()
        print()
        print(dealer.house.description)
        print(dealer.house.description)
        
        for index in 2...4{
            dealer.turn(house: dealer.player)
            if !dealer.player.busted{
                dealer.turn(house: dealer.house)
            }
        }
        
        print("***End of the game hand***")
        let award = dealer.award()
        print(award)
        print(dealer.house.description)
        print(dealer.player.description)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func showLabel() {
        gameEventLabel.isHidden = false
    }
    
    func playBlackjack(withBetOf bet: Int){
        let goodBet = dealer.placeBet(bet: bet)
        if !goodBet{
            return
        }
        print("The bet is \(bet)")
    }
    

    
}
