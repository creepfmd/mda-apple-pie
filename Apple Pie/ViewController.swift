//
//  ViewController.swift
//  Apple Pie
//
//  Created by Сергей on 06.11.2020.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // MARK: - Properties
    var currentGame: Game!
    let incorrectMovesAllowed = 7
    var listOfWords = [
        "Малина",
        "Полина",
        "Калина",
        "Долина",
    ]
    var totalLosses = 0
    var totalWins = 0
    
    // MARK: - Methods
    func newRound() {
        currentGame = Game(word: listOfWords.removeFirst(), incorrectMovesRemaining: incorrectMovesAllowed)
        updateUI()
    }
    
    func getCorrectLabelText() -> String {
        var guessedWordLetters = [String]()
        for letter in currentGame.guessedWord {
            guessedWordLetters.append(String(letter))
        }
        
        return guessedWordLetters.joined(separator: " ")
    }
    
    func updateUI() {
        let movesRemaining = currentGame.incorrectMovesRemaining
        let imageNumber = (movesRemaining + 64) % 8
        let imageName = "Tree_\(imageNumber).pdf"
        treeImageView.image = UIImage(named: imageName)
        correctWordLabel.text = getCorrectLabelText()
        scoreLabel.text = "Выиграно: \(totalWins). Проиграно: \(totalLosses)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    // MARK: - IB Actions
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letter = sender.title(for: .normal)!
        currentGame.playerGuessed(letter: Character(letter))
        updateUI()
    }
    
    
}

