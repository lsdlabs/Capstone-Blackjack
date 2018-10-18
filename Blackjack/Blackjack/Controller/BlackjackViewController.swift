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
    
    @IBOutlet weak var invalidBetWarningMessage: UILabel!
    
    
    @IBOutlet weak var hitButton: UIButton!
    
    @IBOutlet weak var standButton: UIButton!
    @IBOutlet weak var betTextfield: UITextField!
    
    @IBOutlet weak var submitBetButton: UIButton!
    
    
    let dealer = Dealer()
    let house = House.init(name: "House")
    let player = Player(name: "Player")
    //1. initialise the deck
    let deck = Deck.init()
    var userBet = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        enterABet()
        //alertForBet()
        //placeBet(withBet: 10) //call with value in textfield
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
            hitButton.isEnabled = false
            
            while house.mustHit{
                dealer.turn(house: house)
                dealerCards.text = house.cardsInHand
                print(house.cardsInHand)
            }
            
            dealer.turn(house: house)
            dealerCards.text = house.cardsInHand
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
        
        gameEventLabel.text = dealer.winner()
        print(dealer.winner())
    }
    
    
    @IBAction func playerPressedSubmit(_ sender: UIButton) {
//        hitButton.isEnabled = false
//        standButton.isEnabled = false
        isValidBet()
        //validateTheBetOfTheUser(bet: <#T##Int#>)
        hitButton.isEnabled = true
        standButton.isEnabled = true
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
    
    func enterABet(){
        hitButton.isEnabled = false
        standButton.isEnabled = false
        submitBetButton.isEnabled = false
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
    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> (Bool) {
        let text = (betTextfield.text as! NSString).replacingCharacters(in: range, with: string)
        var bet = 0
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
            submitBetButton.isEnabled = false
            hitButton.isEnabled = false
            standButton.isEnabled = false
        }
        
        return true
    }
    
    
    
    
    
    
    func isValidBet()-> Bool{
        //let bet = Int(betTextfield.text!)
        //if betTextfield
        
        guard var betString = betTextfield.text else { return false }
        var bet = Int(betString)
        print(bet)
        guard var betMade = bet else { return false}
        
        validateTheBetOfTheUser(bet: betMade)
        return true
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
    
    func validateTheBetOfTheUser(bet: Int){
        if bet > player.money {
            print("Please enter an amount less than or equal to the number of tokens you have.")
            invalidBetWarningMessage.text = "Please enter an amount less than or equal to the number of tokens you have."
            hitButton.isEnabled = false
            standButton.isEnabled = false
        } else {
        print("\(bet) is an acceptable bet")
        self.userBet = bet
        
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
