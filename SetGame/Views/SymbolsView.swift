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
        let width = size.width * Constatns.shapeWidthRatio
        let height = size.height / Constatns.maxShapesCount - Constatns.Symbolspasing
        return CGSize(width: width ,height: height)}

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
            form.stroke(color, lineWidth: Constatns.lineWidth).frame(
                width: shapeSize.width,
                height: shapeSize.height
            )

        case .filled:
            form.fill(color).frame(
                width: shapeSize.width,
                height: shapeSize.height
            )
        case .striped:
            form.stroke(color, lineWidth: Constatns.lineWidth).frame(
                width: shapeSize.width,
                height: shapeSize.height
            )
            .overlay(
                StripesShape()
                    .stroke(color, lineWidth: Constatns.stripesWidth)
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
    private struct Constatns {
        static let shapeWidthRatio: CGFloat = 0.6
        static let maxShapesCount: CGFloat = 3
        static let Symbolspasing: CGFloat = 10
        static let lineWidth: CGFloat = 1.8
        static let stripesWidth: CGFloat = 2
    }

}

