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
    
    @IBOutlet weak var hitButton: UIButton!
    
    @IBOutlet weak var standButton: UIButton!
    
    
    let dealer = Dealer()
    let house = House.init(name: "House")
    let player = Player(name: "Player")
    //1. initialise the deck
    let deck = Deck.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(deck.summary)
        deck.shuffle()
        print(deck.summary)
        
        house.cards.append(deck.drawCard())
        house.cards.append(deck.drawCard())
        print(house.cardsInHand)
        dealerCards.text = house.cardsInHand
        
        player.cards.append(deck.drawCard())
        player.cards.append(deck.drawCard())
        print(player.cardsInHand)
        playerCards.text = player.cardsInHand
        print(deck.summary)
    }
    
    
    @IBAction func playerPressedHit(_ sender: UIButton) {
    }
    
    @IBAction func playerPressedStand(_ sender: UIButton) {
    }
    
    
}
