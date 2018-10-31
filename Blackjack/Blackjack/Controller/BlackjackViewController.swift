//
//  BlackjackViewController.swift
//  Blackjack
//
//  Created by Lauren Small on 10/10/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import UIKit

class BlackjackViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var gameEventLabel: UILabel!
    @IBOutlet weak var playerCards: UILabel!
    @IBOutlet weak var dealerCards: UILabel!
    @IBOutlet weak var tokensLabel: UILabel!
    @IBOutlet weak var playerTokensLabel: UILabel!
    
    @IBOutlet weak var invalidBetWarningMessage: UILabel!
    
    
    @IBOutlet weak var hitButton: UIButton!
    @IBOutlet weak var standButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBOutlet weak var betTextfield: UITextField!
    @IBOutlet weak var submitBetButton: UIButton!
    
    
    let dealer = Dealer()
    let house = House.init(name: "House")
    let player = Player(name: "Player")
    //1. initialise the deck
    let deck = Deck.init()
    var userBet = 0
    var playerTokens = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Documents folder is: \(documentsDirectory())")
        print("Data File Path is: \(dataFilePath())")
        playerTokens = player.tokens
        playerTokensLabel.text = "\(playerTokens)"
        disableButtonsBeforeUserEntersBet()
        setupTheGame()
       
       
    }
    
    //This function sets up the initial state of the blackjack game
    func setupTheGame() {
        print("Is this the source of all of my headaches?")
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
    
    
    
    
    // MARK: Actions
    
    @IBAction func playerPressedHit(_ sender: UIButton) {
        
        hitButton.isEnabled = true
        player.cards.append(deck.drawCard())
        playerCards.text = player.cardsInHand
        print(deck.summary)
        
        if player.busted{
            print("The House Won :(")
            gameEventLabel.text = "Busted :( The House Won"
            player.didLoseAmount(of: userBet)
            playerTokens = player.tokens
            playerTokensLabel.text = "\(playerTokens)"
            hitButton.isEnabled = false
            
            while house.mustHit{
                dealer.turn(house: house)
                dealerCards.text = house.cardsInHand
                print(house.cardsInHand)
            }
            
            dealer.turn(house: house)
            dealerCards.text = house.cardsInHand
            standButton.isEnabled = false
            playAgainButton.isEnabled = true
            
            saveScore()
        }
        
    }
    
    @IBAction func playerPressedStand(_ sender: UIButton) {
        hitButton.isEnabled = false
        dealer.turn(house: house)
        dealerCards.text = house.cardsInHand
        
        while house.mustHit{
            dealer.turn(house: house)
            dealerCards.text = house.cardsInHand
            print(house.cardsInHand)
        }
        
        standButton.isEnabled = false
        //gameEventLabel.text = dealer.winner()
        gameEventLabel.text = winner(houseHandScore: house.handScore, playerHandSCore: player.handScore)
        print("HOUSE HANDSCORE: \(house.handScore)")
        print("PLAYER HANDSCORE: \(player.handScore)")
        print(dealer.winner())
        //if winner = house, tokens - bet
        //else if winner = player, tokens + bet
        //else tokens = tokens (or tokens + 0)...or don't do anything...don't need an else
        if gameEventLabel.text == "The House Won" {
            player.didLoseAmount(of: userBet)
            playerTokens = player.tokens
            playerTokensLabel.text = "\(playerTokens)"
        } else if gameEventLabel.text == "Congrats! You Won!" {
            player.didWinAmount(of: userBet)
            playerTokens = player.tokens
            playerTokensLabel.text = "\(playerTokens)"
        } else if gameEventLabel.text == "It's A Draw. The House Won" {
            player.didLoseAmount(of: userBet)
            playerTokens = player.tokens
            playerTokensLabel.text = "\(playerTokens)"
        }
        playAgainButton.isEnabled = true
        saveScore()
    }
    
    
    
    
    
    
    
    @IBAction func playerPressedSubmit(_ sender: UIButton) {
//        hitButton.isEnabled = false
//        standButton.isEnabled = false
        let validBet = isValidBet()
        //validateTheBetOfTheUser(bet: <#T##Int#>)
        //betTextfield.text = ""
        if !validBet {
            hitButton.isEnabled = false
            standButton.isEnabled = false
        } else {
        hitButton.isEnabled = true
        standButton.isEnabled = true
        }
        betTextfield.text = ""
    }
    
    @IBAction func playerPressedPlayAgain(_ sender: UIButton) {
        gameEventLabel.text = ""
        playerCards.text = ""
        dealerCards.text = ""
        //setupTheGame()


        print(deck.summary)
        deck.shuffle()
        print(deck.summary)

        player.cards.removeAll()
        player.cards.append(deck.drawCard())
        player.cards.append(deck.drawCard())
//        print(player.cardsInHand)
        playerCards.text = player.cardsInHand
        
        house.cards.removeAll()
        house.cards.append(deck.drawCard())
        house.cards.append(deck.drawCard())
//        print(house.cardsInHand)
        dealerCards.text = house.cardsInHand

        
        print(deck.summary)
    
        saveScore()
        
    }
    
    
    
    
    // MARK: Methods
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("Printing Pathss var")
        print(paths)
        return paths[0]
    }
    
    func dataFilePath() ->URL {
        return documentsDirectory().appendingPathComponent("Blackjack.plist")
    }
    
    
    func saveScore() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(playerTokens)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding playerTokens integer value")
        }
    }
    
    
//    func loadContacts() {
//        let path = dataFilePath()  //datafilelocation
//        if let data = try? Data(contentsOf: path) { //makking a data object and sticking the contacts of our plist in there
//            let decoder = PropertyListDecoder()
//            do {
//                playerTokens = try decoder.decode([Contact].self, from: data)//try to get the stuff from data and decode it into our contacts
//            } catch {
//                print("Error decoding item from array!")
//            }
//        }
//    }
    
    
    
    
    
    func winner(houseHandScore: Int, playerHandSCore: Int) -> String {
        
        var dealerBlackjack = determineBlackjackDealer()
        var playerBlackjack = determineBlackjackPlayer()
        var draw = determineDraw()
        var playerWon = determineIfPlayerIsTheWinner()
        var dealerWon = determineIfDealerIsTheWinner()
        
        if dealerBlackjack {
            print("HOUSE HANDSCORE1: \(house.handScore)")
            print("PLAYER HANDSCORE1: \(player.handScore)")
            return "The House Won"
        } else if playerBlackjack {
            print("HOUSE HANDSCORE2: \(house.handScore)")
            print("PLAYER HANDSCORE2: \(player.handScore)")
            return "Congrats! You Won!"
        } else if draw {
            print("HOUSE HANDSCORE3: \(house.handScore)")
            print("PLAYER HANDSCORE3: \(player.handScore)")
            return "It's A Draw. The House Won"
        } else if playerWon {
            print("HOUSE HANDSCORE4: \(house.handScore)")
            print("PLAYER HANDSCORE4: \(player.handScore)")
            return "Congrats! You Won!"
        } else if dealerWon {
            print("HOUSE HANDSCORE5: \(house.handScore)")
            print("PLAYER HANDSCORE5: \(player.handScore)")
            return "The House Won"
        }
        return "I don't know what is going on"
    }
    
    
    
    func determineBlackjackDealer()-> Bool {
        if !player.blackjack && house.blackjack{
            return true
        } else {
            return false
        }
        
    }
    
    func determineBlackjackPlayer()-> Bool {
        if player.blackjack && !house.blackjack {
            return true
        } else {
            return false
        }
    }
    
    func determineDraw()-> Bool {
        if player.blackjack && house.blackjack {
            return true
        } else {
            return false
        }
    }
    
    
    func determineIfPlayerIsTheWinner()-> Bool {
        if !player.busted && house.busted {
            return true
        } else if house.stayed && player.stayed && player.handScore > house.handScore {
            return true
        } else if !player.busted && !house.busted && player.handScore > house.handScore {
            return true//might not need this
        } else {
            return false
        }
    }
    
    func determineIfDealerIsTheWinner()-> Bool { //could use ||, might seem to long
        if player.busted && house.busted {
            print("Scenario1")
            return true
        } else if player.busted && !house.busted {
            print("Scenario2")
            return true
        } else if house.stayed && player.stayed && player.handScore == house.handScore{
            print("Scenario3")
            return true
        } else if house.stayed && player.stayed && player.busted && house.busted {
            print("Scenario4")
            return true//might not need this
        } else if  house.stayed && player.stayed && house.handScore > player.handScore{
            print("Scenario5")
            return true
        } else if !house.busted && !player.busted && house.handScore > player.handScore {
            print("Scenario6")
            return true
        } else if player.handScore == house.handScore {
            print("Scenario7")
            return true
        } else {
            return false
        }
    }
    


    func placeBet(withBet bet: Int){
        
    }
    

    
    
    //This function disables the button to submit a bet, and the hit and stand buttons before the user enters a bet
    func disableButtonsBeforeUserEntersBet(){
        hitButton.isEnabled = false
        standButton.isEnabled = false
        submitBetButton.isEnabled = false
        playAgainButton.isEnabled = false
        betTextfield.delegate = self
        //isValidBet()
    }
    
    
    
    //delegate method...checking if the input is an integer or not...also calls
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> (Bool) {
        let text = (betTextfield.text as! NSString).replacingCharacters(in: range, with: string)
        var bet = 0
        //var validBet = false
        if let intValue = Int(text) {
            bet = intValue
            print("Input is an integer")
            var validBet = isValidBet()
            if validBet{
//                submitBetButton.isEnabled = true
//                hitButton.isEnabled = true
//                standButton.isEnabled = true
                //submitBetButton.isEnabled = true
            }
            submitBetButton.isEnabled = true
        } else {
            print("Input is not an integer")
            var validBet = false
            submitBetButton.isEnabled = false
            hitButton.isEnabled = false
            standButton.isEnabled = false
        }
        
        return true
        
    }
    
    
    //determines if the bet is valid solely based on input, not if it's a "legal" bet
    //this method then calls to validateTheBetOfTheUser to ensure the user has enough money/tokens
    func isValidBet()-> Bool{
        //let bet = Int(betTextfield.text!)
        //if betTextfield
        
        guard var betString = betTextfield.text else { return false }
        var bet = Int(betString)
        print(bet)
        guard var betMade = bet else { return false}
        
        var validBetCheck = validateTheBetOfTheUser(bet: betMade)
        return validBetCheck
    }
    
    
 
    //This function lets the user know if he or she has bet more money than he or she has
    func validateTheBetOfTheUser(bet: Int)-> Bool{
        if bet > player.tokens {
            print("Please enter an amount less than or equal to the number of tokens you have.")
            invalidBetWarningMessage.text = "Please enter an amount less than or equal to the number of tokens you have."
            hitButton.isEnabled = false
            standButton.isEnabled = false
            return false
        } else {
        print("\(bet) is an acceptable bet")
        invalidBetWarningMessage.text = ""
        self.userBet = bet
            return true
    }
    }
}


































/*
 private func validate(_ textField: UITextField) -> (Bool, String?) {
 guard let text = textField.text else {
 return (false, nil)
 }
 return (text.count > 0, "This Field Cannot Be Empty.")
 
 
 //        guard let eventTitle = titleField.text, let giftRecipient = recipientField.text, let eventNotes = notesTextView.text else { return }
 //
 //        let event = Event(eventTitle: eventTitle, giftRecipient: giftRecipient, dateOfEventString: dateString, haveGift: haveGiftSwitch.isOn, eventNotes: eventNotes)
 //                delegate?.addEventViewController(self, didFinishAdding: event)
 
 }

 */


//extension BlackjackViewController: UITextFieldDelegate {
//    betTextfield.delegate = self
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        let allowedCharacters = ".0123456789"
//        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
//        let typedCharacterSet = CharacterSet(charactersIn: string)
//
//        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
//
//    }
//}
