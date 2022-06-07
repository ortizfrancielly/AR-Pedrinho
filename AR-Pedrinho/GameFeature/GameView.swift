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
    
    var body: some View {
        ZStack {
//            ARViewContainer(delegate: viewModel.delegate)
//                .ignoresSafeArea()
            
            overlay
        }
        //.onAppear(perform: viewModel.startUp)
    }
    
    @ViewBuilder
    private var overlay: some View {
        VStack {
            HStack {
                Spacer()
                Text("Score: **\(viewModel.score)**")
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(4)
            }
            Spacer()
            Group {
                SoundPlayer(shouldPlay: $viewModel.shouldPlay,
                            color: .purple)
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
        GameView()
    }
}
#endif
