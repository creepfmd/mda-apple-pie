//
//  ViewController.swift
//  Apple Pie
//
//  Created by Сергей on 06.11.2020.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var gameTypeStackView: UIStackView!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var gameStackView: UIStackView!
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // MARK: - Properties
    var currentGame: Game!
    let incorrectMovesAllowed = 7
    var listOfWords = [String]()
    var totalWords = 0
    var totalLosses = 0 {
        didSet {
            if totalLosses > 0 {
                newRound()
            }
        }
    }
    var totalWins = 0 {
        didSet {
            if totalWins > 0 {
                newRound()
            }
        }
    }
    
    // MARK: - Methods
    func enableButtons(_ enable: Bool = true) {
        for letterButton in letterButtons {
            letterButton.isEnabled = enable
        }
    }
    
    func getCorrectLabelText() -> String {
        return currentGame.guessedWord.map({ (letter) in String(letter)}).joined(separator: " ")
    }
    
    func newGame() {
        gameStackView.isHidden = true
        newGameButton.isHidden = true
        gameTypeStackView.isHidden = false
        totalWins = 0
        totalLosses = 0
    }
    
    func startGame(withWordList: [String]) {
        listOfWords = withWordList.shuffled()
        totalWords = listOfWords.count
        gameTypeStackView.isHidden = true
        gameStackView.isHidden = false
        newGameButton.isHidden = false
        newRound()
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
        scoreLabel.text = "Выиграно: \(totalWins)/\(totalWords). Проиграно: \(totalLosses)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
    }
    
    // MARK: - IB Actions
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letter = sender.title(for: .normal)!
        currentGame.playerGuessed(letter: Character(letter))
        updateGameState()
    }
    
    @IBAction func newGameButtonPressed(_ sender: Any) {
        newGame()
    }
    
    @IBAction func unitedStatesButtonPressed() {
        startGame(withWordList: ListOfWords().unitedStates)
    }
    
    @IBAction func indiaStatesButtonPressed() {
        startGame(withWordList: ListOfWords().indiaStates)
    }
    
    @IBAction func countriesButtonPressed() {
        startGame(withWordList: ListOfWords().countries)
    }
    
    @IBAction func citiesButtonPressed() {
        startGame(withWordList: ListOfWords().cities)
    }
}

