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
        
    }
    
    
    @IBAction func playerPressedHit(_ sender: UIButton) {
    }
    
    @IBAction func playerPressedStand(_ sender: UIButton) {
    }
    
    
}
