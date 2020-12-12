//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by 堺雄之介 on 2020/09/17.
//  Copyright © 2020 堺雄之介. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let themes = [
            MemoryGame.CardTheme(name: "Halloween", content: ["👻", "🎃", "🕷", "🍭", "🕯", "🍬"], color: UIColor.RGB(red: 255/255, green: 149/255, blue: 0/255, alpha: 1)),
            MemoryGame.CardTheme(name: "Winter", content: ["🎄", "☃️", "⛄️", "🍰", "❄️", "⛷"], color: UIColor.RGB(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)),
            MemoryGame.CardTheme(name: "Animal", content: ["🐶", "🐱", "🐰", "🦊", "🐼", "🐯"], color: UIColor.RGB(red: 52/255, green: 199/255, blue: 89/255, alpha: 1)),
            MemoryGame.CardTheme(name: "Faces", content: ["😀", "😂", "😇", "😉", "🤔", "🥺"], color: UIColor.RGB(red: 255/255, green: 59/255, blue: 48/255, alpha: 1)),
            MemoryGame.CardTheme(name: "Fruits", content: ["🍎", "🍊", "🍋", "🍓", "🍉", "🍒"], color: UIColor.RGB(red: 175/255, green: 82/255, blue: 222/255, alpha: 1)),
            MemoryGame.CardTheme(name: "Food", content: ["🍔", "🌮", "🍜", "🍣", "🍙", "🍮"], color: UIColor.RGB(red: 255/255, green: 45/255, blue: 85/255, alpha: 1)),
        ]
        
        let theme = themes.randomElement()!
        
        return MemoryGame<String>(theme: theme) { pairIndex in
            return theme.content[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    var theme: MemoryGame<String>.CardTheme {
        return model.theme
    }
    
    var score: Int {
        return model.score
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
