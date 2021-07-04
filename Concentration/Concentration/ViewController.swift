//
//  ViewController.swift
//  Concentration
//
//  Created by Danil Nurgaliev on 04.07.2021.
//

import UIKit

class ViewController: UIViewController {
    var flipsCount = 0 {
        didSet {
            flipsCountLabel.text = "Flips: \(flipsCount)"
        }
    }

    @IBOutlet weak var flipsCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    var emojiChoices = ["🐶", "🐻", "🐶", "🐻"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func touchCard(_ sender: UIButton) {
        flipsCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        }
    }

    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = .red
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = .white
        }
    }
}
