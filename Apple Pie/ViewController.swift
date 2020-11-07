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
    ].shuffled()
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    // MARK: - Methods
    func enableButtons(_ enable: Bool = true) {
        for letterButton in letterButtons {
            letterButton.isEnabled = enable
        }
    }
    
    func getCorrectLabelText() -> String {
        var guessedWordLetters = [String]()
        for letter in currentGame.guessedWord {
            guessedWordLetters.append(String(letter))
        }
        
        return guessedWordLetters.joined(separator: " ")
    }
    
    func newRound() {
        guard !listOfWords.isEmpty else {
            updateUI()
            enableButtons(false)
            return
        }
        currentGame = Game(word: listOfWords.removeFirst(), incorrectMovesRemaining: incorrectMovesAllowed)
        enableButtons()
        updateUI()
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining < 1 {
            totalLosses += 1
        } else if currentGame.guessedWord == currentGame.word {
            totalWins += 1
        } else {
            updateUI()
        }
        updateUI()
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
        updateGameState()
    }
    
    
}

