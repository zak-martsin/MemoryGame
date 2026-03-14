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
        }
        .padding()
    }
    
    var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio){ card in
            CardView(card: card)
                .padding(4)
        }
        .foregroundColor(.black)
    }
    
    
    
    
    
    
    
}















#Preview {
    SetGameView(viewModel: ViewModel())
}






