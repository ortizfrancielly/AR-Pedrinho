//
//  EndGameView.swift
//  AR-Pedrinho
//
//  Created by Gabriel Ferreira de Carvalho on 08/06/22.
//

import SwiftUI

struct EndGameView: View {
    @Environment(\.dismiss) var dismiss
    var score: Int
    @Binding var isStillNavigating: Bool
    
    func scoreAttributedString(score: Int) -> AttributedString {
        var string = try! AttributedString(markdown: "Sua pontuação foi: **\(score)**")
        string.foregroundColor = Color("color-1")
        
        if let numberRange = string.range(of: "\(score)") {
            string[numberRange].foregroundColor = Color("color-3")
        }
        
        return string
    }
    
    var body: some View {
        VStack {
            Text("Fim de Jogo")
                .font(.largeTitle.bold())
                .foregroundColor(Color("color-1"))
            
            Text(scoreAttributedString(score: score))
                .font(.title3)
                .padding(.vertical, 4)
            
            Button("Menu Principal") {
                isStillNavigating = false
            }
            .padding(.vertical)
            .buttonStyle(.borderedProminent)
            .font(.headline.bold())
            
            Button("Jogar de novo ") {
                dismiss.callAsFunction()
            }
            .buttonStyle(.borderedProminent)
            .font(.headline.bold())
        }
        .frame(maxWidth: .infinity)
        .padding(32)
        .background(Color(uiColor: .secondarySystemBackground))
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color("color-1"))
        )
        .padding(32)
        .tint(Color("color-3"))
        .navigationBarHidden(true)
        .shadow(radius: 2)
        .onAppear {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
    }
}

struct EndGameView_Previews: PreviewProvider {
    static var previews: some View {
        EndGameView(score: 34, isStillNavigating: .constant(true))
            .preferredColorScheme(.light)
            
    }
}
