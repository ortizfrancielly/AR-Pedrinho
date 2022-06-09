//
//  MenuView.swift
//  AR-Pedrinho
//
//  Created by Gabriel Ferreira de Carvalho on 07/06/22.
//

import SwiftUI

struct MenuView: View {
    @State
    var isPlayingGame: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                title
                Spacer()
                Spacer()
                NavigationLink("Jogar", isActive: $isPlayingGame) {
                    GameView(viewModel: GameViewModel(), isPlayingGame: $isPlayingGame)
                }
                .buttonStyle(.borderedProminent)
                .foregroundColor(.white)
                .tint(Color("color-3"))
                .font(.largeTitle.bold())
                Spacer()
            }
            .fullScreenBackground(of: Color(uiColor: .secondarySystemBackground))
            .navigationBarHidden(true)
        }
    }
    
    var titleString: AttributedString {
        var string = AttributedString("ARcorda")
        string.foregroundColor = Color("color-1")
        
        if let range = string.range(of: "AR") {
            string[range].foregroundColor = Color("color-3")
        }
        
        return string
    }
    
    @ViewBuilder
    var title: some View {
        VStack {
            Text(titleString)
                .font(.system(size: 74))
                .fontWeight(.black)
                .foregroundColor(.indigo)
                
            HStack {
                Spacer()
                Text("Pedrinho")
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .foregroundColor(Color("color-1"))
                    .padding(.horizontal, 24)
                    .background(
                        Capsule()
                            .stroke(Color("color-3"),
                                    lineWidth: 4)
                    )
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

extension View {
    
    @ViewBuilder
    func fullScreenBackground(of color: Color) -> some View {
        ZStack {
            color.ignoresSafeArea()
            self
        }
    }
}
