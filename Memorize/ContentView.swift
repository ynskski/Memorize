//
//  ContentView.swift
//  Memorize
//
//  Created by 堺雄之介 on 2020/09/17.
//  Copyright © 2020 堺雄之介. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            }
        }
            .padding()
            .foregroundColor(Color.orange)
            .font(viewModel.cards.count > 9 ? .caption : .largeTitle)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.white)
                    .aspectRatio(1/1.5, contentMode: .fit)
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(lineWidth: 3)
                    .aspectRatio(1/1.5, contentMode: .fit)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill()
                    .aspectRatio(1/1.5, contentMode: .fit)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
