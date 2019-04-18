//
//  ViewController.swift
//  Concentration
//
//  Created by Esraa on 4/6/19.
//  Copyright © 2019 Esraa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game : Concentration = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount : Int = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var newGameButton: UIButton!
    
    var emojiChoices: Array<String> = ["👻", "🎃" , "🍭", "😈", "😱", "🙀", "🍎", "🍬", "🦇"]
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        let cardNumber = cardButtons.index(of: sender)!
        game.chooseACard(at: cardNumber)
        updateViewFromModel()
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji (for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.580126236, blue: 0.01286631583, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil , emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        flipAllCards()
    }
    
    func flipAllCards(){
        flipCount = 0
        for index in cardButtons.indices {
            game.flipAllCards(index: index)
            updateViewFromModel()
        }
    }
}

