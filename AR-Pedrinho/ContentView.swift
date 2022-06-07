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

struct ContentView : View {
    @State var frequency: Int = 3
    @State var time: Int = 0
    @State var shouldPlay: Bool = true
    @State var score: Int = 34
    
    private let timer = Timer.publish(every: 1,
                                      on: .main,
                                      in: .default).autoconnect()
    
    var body: some View {
        ZStack {
            Rectangle().fill(.black).ignoresSafeArea()
            //ARViewContainer().ignoresSafeArea()
            overlay
        }
        .onReceive(timer) { _ in
            time += 1
            
            if time % frequency == 0 {
                shouldPlay.toggle()
                frequency = Int.random(in: 4...10)
            }
            
            print("time: \(time)", "frequency: \(frequency)")
        }
    }
    
    @ViewBuilder
    private var overlay: some View {
        VStack {
            HStack {
                Spacer()
                Text("Score: **\(score)**")
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(4)
            }
            Spacer()
            Group {
                SoundPlayer(shouldPlay: $shouldPlay, color: .purple)
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
        ContentView()
    }
}
#endif
