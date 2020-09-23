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
    
    static func createMemoryGame() -> MemoryGame<String> {
        let themes = [
            MemoryGame.CardTheme(name: "Halloween", content: ["👻", "🎃", "🕷", "🍭", "🕯"], color: .orange),
            MemoryGame.CardTheme(name: "Winter", content: ["🎄", "☃️", "⛄️", "🍰", "❄️"], color: .blue),
            MemoryGame.CardTheme(name: "Animal", content: ["🐶", "🐱", "🐰", "🦊", "🐼"], color: .green),
            MemoryGame.CardTheme(name: "Faces", content: ["😀", "😂", "😇", "😉", "🤔"], color: .red),
            MemoryGame.CardTheme(name: "Fruits", content: ["🍎", "🍊", "🍋", "🍓", "🍉"], color: .purple),
            MemoryGame.CardTheme(name: "Food", content: ["🍔", "🌮", "🍜", "🍣", "🍙"], color: .pink),
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
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
