//
//  SymbolsView.swift
//  SetGame
//
//  Created by Захар Марцинкевич on 14/03/2026.
//

import SwiftUI

struct SymbolsView: View {
    let card: SetGameModel.Card
    let size: CGSize
    var shapeSize: CGSize {
        CGSize(width: size.width * 0.6,
               height: size.height / 3 - 7) // OneShapeHeight - spasing
    }
    init(for card: SetGameModel.Card,in  size: CGSize) {
        self.card = card
        self.size = size
    }
    
    var body: some View {
        makeShapes()
    }
    
   private func makeShapes () -> some View {
        VStack(spacing: 3){
            ForEach(0..<card.quantity, id: \.self){_  in
                formSetter()
                
            }
        }
    }
    
    
    
    @ViewBuilder
    private   func formSetter () -> some View {
        switch card.shape {
        case .rectangle:
            fillerSetter(for: Rectangle())
        case .oval:
            fillerSetter(for: Ellipse())
        case .diamond:
            fillerSetter(for: DiamondShape())
        }
    }
    
    
    @ViewBuilder
    private func fillerSetter (for form: some Shape) -> some View{
        
        switch card.shading{
        case .empty:
            form.stroke(color, lineWidth: 1.8).frame(
                width: shapeSize.width,
                height: shapeSize.height
            )
            
        case .filled:
            form.fill(color).frame(
                width: shapeSize.width,
                height: shapeSize.height
            )
        case .striped:
            form.stroke(color, lineWidth: 1.8).frame(
                width: shapeSize.width,
                height: shapeSize.height
            )
            .overlay(
                StripesShape()
                    .stroke(color, lineWidth: 2)
                    .clipShape(form)
            )
        }
    }
    
    
    private   var color: Color {
        switch card.color {
        case .red:
            return .red
        case .blue:
            return .blue
        case .green:
            return .green
        }
    }
    
}

