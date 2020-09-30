//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by 堺雄之介 on 2020/09/17.
//  Copyright © 2020 堺雄之介. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        NavigationView {
            VStack {
                Text(viewModel.score.description).font(.title)
                
                Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        viewModel.choose(card: card)
                    }
                    .padding(5)
                }
                    .padding([.leading, .trailing], 10)
                    .foregroundColor(viewModel.theme.color)
                    .edgesIgnoringSafeArea(.top)
            }
            .navigationBarTitle(Text(viewModel.theme.name))
            .navigationBarItems(trailing: Button {
                viewModel.resetGame()
            } label: {
                Image(systemName: "goforward")
            })
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
                    .padding(5)
                    .opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    // MARK: - Drawing Constants

    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
