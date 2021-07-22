//
//  Concentration.swift
//  Concentration
//
//  Created by Danil Nurgaliev on 04.07.2021.
//

import Foundation

private struct Points {
    static let matchBonus = 2
    static let missMatchPenalty = 1
}

class Concentration {
    private(set) var cards = [Card]()

    private(set) var flipsCount = 0
    private(set) var score = 0
    private var seenCards: Set<Int> = []

    private(set) var emojiThemes: [String: [String]] = [
        "Animals" : ["🐶", "🐱", "🐭", "🐹", "🐰", "🐻", "🧸", "🐼", "🐻‍❄️", "🐨"],
        "Eats" : ["🍏", "🍎", "🍟", "🍔", "🍐", "🍋", "🍌", "🍉", "🍇", "🍈", "🫐", "🥭"],
        "Sport": ["⚽", "🏀", "🏋️‍♀️", "🏈", "🏊", "🏂", "⛸", "🥋", "🥊", "🏒" , "🎾", "🎮"]]
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            flipsCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true

                    score += Points.matchBonus
                } else {
                    if seenCards.contains(index) {
                        score -= Points.missMatchPenalty
                    }
                    if seenCards.contains(matchIndex) {
                        score -= Points.missMatchPenalty
                    }
                    seenCards.insert(matchIndex)
                    seenCards.insert(index)
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }

    func newGame() {
        flipsCount = 0
        for i in cards.indices {
            cards[i].isFaceUp = false
            cards[i].isMatched = false
        }
        cards.shuffle()
    }
    
    init(numberOfPairsOfCard: Int) {
        for _ in 1...numberOfPairsOfCard {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
