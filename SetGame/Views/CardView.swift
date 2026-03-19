//
//  CardView.swift
//  SetGame
//
//  Created by Захар Марцинкевич on 06/03/2026.
//
import SwiftUI

struct CardView: View {
    let card: SetGameModel.Card
  
    var body: some View {
        GeometryReader { geo in
            ZStack{
                let base = RoundedRectangle(cornerRadius: 12)
                Group {
                    base.fill(.white)
                    base.strokeBorder(cardColor,lineWidth: 3)
                    SymbolsView(for: card,in: geo.size)

                }
            }
        }
    }

    var cardColor: Color {
        switch visualState {
        case .normal:
                .black
        case .selected:
                .blue
        case .matched:
                .green
        case .mismatched:
                .red
        }
    }

    var visualState: CardVisualState {
        switch (card.isSelected, card.matchStatus) {
        case (false, .neither):
            return .normal
        case (true, .neither):
            return .selected
        case (_, .matched):
            return .matched
        case (_, .mismatched):
            return .mismatched
        }
    }

    enum CardVisualState{
        case normal
        case selected
        case matched
        case mismatched
    }



}
