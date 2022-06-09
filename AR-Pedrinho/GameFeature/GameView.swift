//
//  ContentView.swift
//  AR-Pedrinho
//
//  Created by Francielly Cristina Ortiz Candido on 02/06/22.
//
import AVFoundation
import SwiftUI
import RealityKit
import SceneKit

struct GameView : View {
    @ObservedObject var viewModel: GameViewModel = .init()
    @Binding var isPlayingGame: Bool
    
    var body: some View {
        ZStack {
//            ARViewContainer(delegate: viewModel.delegate)
//                .ignoresSafeArea()
            
            overlay
        }
        .background(
            NavigationLink(isActive: $viewModel.isGameOver){
                EndGameView(score: viewModel.score,
                            isStillNavigating: $isPlayingGame)
            } label: {
                EmptyView()
            }
        )
        .navigationBarHidden(true)
        .onAppear(perform: viewModel.startUp)
        .onDisappear(perform: viewModel.finish)
    }
    
    func scoreText(for score: Int) -> AttributedString {
        var string = AttributedString("Pontos: \(score)")
        string.foregroundColor = Color("color-1")
        
        if let range = string.range(of: "\(score)") {
            string[range].foregroundColor = Color("color-3")
            string[range].font = .body.bold()
        }
        
        return string
    }
    
    @ViewBuilder
    private var overlay: some View {
        VStack {
            HStack {
                Spacer()
                Text(scoreText(for: viewModel.score))
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(4)
                    .padding(.trailing, 8)
            }
            Spacer()
            Group {
                SoundPlayer(shouldPlay: $viewModel.shouldPlay,
                            color: [Color("color-1"), Color("color-3")])
                    .frame(height: 150)
            }
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        GameView(isPlayingGame: .constant(true))
    }
}
#endif
