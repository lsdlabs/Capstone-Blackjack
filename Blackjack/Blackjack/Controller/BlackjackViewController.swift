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
        
    }
    
    
    
    func playBlackjack(withBetOf bet: Int){
        let goodBet = dealer.placeBet(bet: bet)
        if !goodBet{
            return
        }
        print("The bet is \(bet)")
    }
    
    
    @IBAction func playerPressedHit(_ sender: UIButton) {
    }
    
    @IBAction func playerPressedStand(_ sender: UIButton) {
    }
    
    
}
