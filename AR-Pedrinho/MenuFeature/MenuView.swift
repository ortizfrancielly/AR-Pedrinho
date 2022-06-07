//
//  MenuView.swift
//  AR-Pedrinho
//
//  Created by Gabriel Ferreira de Carvalho on 07/06/22.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            Spacer()
            title
            Spacer()
            Spacer()
            Spacer()
        }
    }
    
    @ViewBuilder
    var title: some View {
        VStack {
            Text("ACORDA")
                .font(.system(size: 74))
                .fontWeight(.black)
                .foregroundLinearGradient(colors: [.blue, .blue, .red, .yellow], startPoint: .top, endPoint: .bottom)
                
            HStack {
                Spacer()
                Text("Pedrinho")
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .foregroundLinearGradient(colors: [.blue, .blue, .red, .yellow], startPoint: .top, endPoint: .bottom)
                    .padding(.horizontal, 24)
                    .background(Capsule().stroke(.blue, lineWidth: 4))
                    .padding(.trailing, 32)
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

extension Text {
    public func foregroundLinearGradient(
        colors: [Color],
        startPoint: UnitPoint,
        endPoint: UnitPoint) -> some View
    {
        self.overlay {

            LinearGradient(
                colors: colors,
                startPoint: startPoint,
                endPoint: endPoint
            )
            .mask(
                self

            )
        }
    }
}
