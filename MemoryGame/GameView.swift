//
//  ContentView.swift
//  MemoryGame
//
//  Created by Захар Марцинкевич on 28/02/2026.
//

import SwiftUI

struct MemoryGameView: View {
    private let aspectRatio: CGFloat = 2/3

    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack {
            cards
        }
        .padding()
    }

    var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio){ card in
                CardView(card: card)
                    .padding(4)
            }
        .foregroundColor(cardColor)
        }




    var cardColor: Color {
        switch viewModel.currentTheme.color {
        case "blue":
            return .blue
        case "green":
            return .green
        case "yellow":
            return .yellow
        case "red":
            return .red
        case "orange":
            return .orange
        default:
            return .brown
        }
    }



    }











struct CardView: View {
    let card: MemoryGameModel<String>.Card
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                    .strokeBorder()
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isMatched ? 0 : 1)
    }
}




#Preview {
    MemoryGameView(viewModel: ViewModel())
}





