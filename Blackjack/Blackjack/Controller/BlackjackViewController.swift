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
        playerTokens = player.tokens
        playerTokensLabel.text = "\(playerTokens)"
        
        print("before disabling buttons")
        disableButtonsBeforeUserEntersBet()
        print("after disabling buttons")
        print("before setting up the game")
        setupTheGame()
        print("after setting up the game")
        //alertForBet()
        //placeBet(withBet: 10) //call with value in textfield
//        print(deck.summary)
//        deck.shuffle()
//        print(deck.summary)
//
//        house.cards.append(deck.drawCard())
//        house.cards.append(deck.drawCard())
//        print(house.cardsInHand)
//        dealerCards.text = house.cardsInHand
//
//        player.cards.append(deck.drawCard())
//        player.cards.append(deck.drawCard())
//        print(player.cardsInHand)
//        playerCards.text = player.cardsInHand
//        print(deck.summary)
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
    
    @IBAction func playerPressedHit(_ sender: UIButton) {
        
        hitButton.isEnabled = true
        player.cards.append(deck.drawCard())
        playerCards.text = player.cardsInHand
        print(deck.summary)
        
        if player.busted{
            print("The House Won :(")
            gameEventLabel.text = "The House Won"
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
        gameEventLabel.text = dealer.winner()
        print(dealer.winner())
        //if winner = house, tokens - bet
        //else if winner = player, tokens + bet
        //else tokens = tokens (or tokens + 0)...or don't do anything...don't need an else
        if gameEventLabel.text == "house" {
            player.didLoseAmount(of: userBet)
            playerTokens = player.tokens
            playerTokensLabel.text = "\(playerTokens)"
        } else if gameEventLabel.text == "player" {
            player.didWinAmount(of: userBet)
            playerTokens = player.tokens
            playerTokensLabel.text = "\(playerTokens)"
        }
        playAgainButton.isEnabled = true
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
    
        
    }
    

    
    
    
    
    
    
    

    func placeBet(withBet bet: Int){
        
    }
    
//    func allowedCharacters(){
//       // betTextfield.delegate = self
//
//        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//            let allowedCharacters = ".0123456789"
//            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
//            let typedCharacterSet = CharacterSet(charactersIn: string)
//
//            return allowedCharacterSet.isSuperset(of: typedCharacterSet)
//
//        }
//    }
    
//    func enterABet()-> String{
//         betTextfield.delegate = self
//        guard let bet = betTextfield.text else { return  ""}
//        }
//
//    return "This field" 
//}
//
    
    
    //This function disables the button to submit a bet, and the hit and stand buttons before the user enters a bet
    func disableButtonsBeforeUserEntersBet(){
        hitButton.isEnabled = false
        standButton.isEnabled = false
        submitBetButton.isEnabled = false
        playAgainButton.isEnabled = false
        betTextfield.delegate = self
        //isValidBet()
    }
    
    //makes sure only numbers are entered
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> (Bool, Int) {
//        let text = (betTextfield.text as! NSString).replacingCharacters(in: range, with: string)
//        var bet = 0
//        if let intValue = Int(text) {
//            bet = intValue
//            print("Input is an integer")
//            submitBetButton.isEnabled = true
//        } else {
//            print("Input is not an integer")
//            submitBetButton.isEnabled = false
//        }
//        return (true, bet)
//    }
    
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> (Bool) {
//        let text = (betTextfield.text as! NSString).replacingCharacters(in: range, with: string)
//        var bet = 0
//        if let intValue = Int(text) {
//            bet = intValue
//            print("Input is an integer")
//            var validBet = isValidBet()
//            if validBet{
//                submitBetButton.isEnabled = true
//                hitButton.isEnabled = true
//                standButton.isEnabled = true
//
//            }
//            submitBetButton.isEnabled = true
//        } else {
//            print("Input is not an integer")
//            submitBetButton.isEnabled = false
//            hitButton.isEnabled = false
//            standButton.isEnabled = false
//        }
//        return true
//    }
    
    
    
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
    
    
    
    
    
    //determines if the bet is valid soley based on input, not if it's a "legal" bet
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
    
    
    //converts textfield input to an int, checks to see if the bet is allowed, if bet is allowed, funds are added to the player's total
//    func isValidBet()-> Bool{
//        //let bet = Int(betTextfield.text!)
//        //if betTextfield
//
//        guard var betString = betTextfield.text else { return false }
//        var bet = Int(betString)
//        print(bet)
//        guard var betMade = bet else { return false}
////        if player.canPlaceABet(of: betMade){
////            //player.didWinAmount(of: betMade)//can't do this yet...this can only be done if the player wins the round
////            //commence game
////            print("hit button is enabled")
////            hitButton.isEnabled = true
////            print("stand button is enabled")
////            standButton.isEnabled = true
////            return true
////        } else {
////            return false
////        }
//        validateTheBetOfTheUser(bet: betMade)
//        return true
//    }
    //look into textfield delegate methods
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
