//
//  Concentration.swift
//  Concentration
//
//  Created by Esraa on 4/6/19.
//  Copyright © 2019 Esraa. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseACard(at index: Int){
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func flipAllCards(index: Int){
        cards[index].isFaceUp = false
        cards[index].isMatched = false
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 00..<numberOfPairsOfCards{
            let card = Card()
            cards.append(card)
            cards.append(card)
        }
    }
    
    //TODO: Shuffle the cards
}
