//
//  ContentView.swift
//  MemoryGame
//
//  Created by Захар Марцинкевич on 28/02/2026.
//

import SwiftUI

struct SetGameView: View {
    private let aspectRatio: CGFloat = 2/3
    
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack {
            cards
            HStack(spacing: 80){
                createNewGame
                cardAdder
                    .opacity(viewModel.cardsOnTheDeck.isEmpty ? 0 : 1)
            }
        }
        .padding()
    }
    
    var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio){ card in
            CardView(card: card)
                .padding(4)
                .onTapGesture { viewModel.choose(card: card) }
        }
    }
    
    
    var createNewGame: some View {
        Button ("New Game"){
            viewModel.createNewGame()
        }
        .font(.largeTitle)
    }

    var cardAdder: some View {
        Button ("+3"){
            viewModel.dealThreeCardsToBoard()
        }
        .font(.largeTitle)
    }

}















#Preview {
    SetGameView(viewModel: ViewModel())
}






