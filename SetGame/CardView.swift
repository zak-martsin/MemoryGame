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
                    base.strokeBorder(lineWidth: 3)
                    SymbolsView(for: card,in: geo.size)

                }
            }
        }
    }




}
