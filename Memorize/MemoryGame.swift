//
//  MemoryGame.swift
//  Memorize
//
//  Created by 堺雄之介 on 2020/09/17.
//  Copyright © 2020 堺雄之介. All rights reserved.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private(set) var theme: CardTheme
    private(set) var score: Int
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        print("card choosen: \(card)")
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    score -= 1
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(theme: CardTheme, cardContentFactory: (Int) -> CardContent) {
        self.score = 0
        self.theme = theme
        
        cards = [Card]()
        
        for pairIndex in 0..<theme.numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
        
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        var content: CardContent
        
        // MARK: - Bonus Time
        
        // this could give matching bonus points
        // if the user matches the card
        // before a certain amount of time passes during which the card is face up
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            return max(0, bonusTimeLimit - faceUpTime)
        }
        
        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            if bonusTimeLimit > 0 && bonusTimeRemaining > 0 {
                return bonusTimeRemaining / bonusTimeLimit
            } else {
                return 0
            }
        }
        
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            return isMatched && bonusTimeRemaining > 0
        }
        
        // whether we are currently face up, unmatched and have not yet userd up the bonus window
        var isConsumingBonusTime: Bool {
            return isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // called when the card goes back face down (or get matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
    
    struct CardTheme {
        var name: String
        var content: [CardContent]
        var color: Color
        
        var numberOfPairsOfCards: Int {
            return [3, 4, 6].randomElement()!
        }
    }
}
