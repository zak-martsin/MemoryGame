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
        .foregroundColor(.red)
        }







    }











struct CardView: View {
    let card: SetGameModel.Card
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 3)
//                Text(card)
//                    .font(.system(size: 200))
//                    .minimumScaleFactor(0.01)
//                    .aspectRatio(1, contentMode: .fit)
            }
        }
    }
}




#Preview {
    SetGameView(viewModel: ViewModel())
}





