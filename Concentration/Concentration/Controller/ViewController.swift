//
//  ViewController.swift
//  Concentration
//
//  Created by Danil Nurgaliev on 04.07.2021.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCard: numberOfPairsOfCard)

    private var numberOfPairsOfCard: Int {
        return cardButtons.count / 2
    }

    private var emojiChoices: [String] = []

    private var emoji = [Card : String]()

    private var keys: [String] {
        return Array(game.emojiThemes.keys)
    }

    private var indexTheme = 0 {
        didSet {
            emojiChoices = game.emojiThemes[keys [indexTheme]] ?? []
            titleLabel.text = keys[indexTheme]
            emoji = [Card : String]()
        }
    }

    @IBOutlet private weak var flipsCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var newGameButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        newGameButton.layer.cornerRadius = newGameButton.frame.height / 2
        indexTheme = keys.count.arc4random
    }

    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }


    @IBAction private func newGameTapped(_ sender: UIButton) {
        game.newGame()
        indexTheme = keys.count.arc4random
        updateViewFromModel()
    }

    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]

            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .clear : .red
            }
        }

        flipsCountLabel.text = "Flips: \(game.flipsCount)"
        scoreLabel.text = "Score: \(game.score)"
    }

    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0  {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
