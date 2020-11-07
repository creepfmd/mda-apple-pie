//
//  Game.swift
//  Apple Pie
//
//  Created by Сергей on 06.11.2020.
//

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    fileprivate var guessedLetters = [Character]()
    
    init(word: String, incorrectMovesRemaining: Int) {
        self.word = word
        self.incorrectMovesRemaining = incorrectMovesRemaining
    }
    
    var guessedWord: String {
        var label = ""
        for letter in word {
            if guessedLetters.contains(Character(letter.lowercased())) || !letter.isLetter {
                label += "\(letter)"
            } else {
                label += "_"
            }
        }
        
        return label
    }
    
    mutating func playerGuessed(letter: Character) {
        let lowercasedLetter = Character(letter.lowercased())
        guessedLetters.append(lowercasedLetter)
        if !word.lowercased().contains(lowercasedLetter) {
            incorrectMovesRemaining -= 1
        }        
    }
}
