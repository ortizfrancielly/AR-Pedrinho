//
//  SoundPlayer.swift
//  AR-Pedrinho
//
//  Created by Gabriel Ferreira de Carvalho on 06/06/22.
//

import AVFoundation
import SwiftUI

struct SoundPlayer: View {
    

    private let frequency = Timer.publish(every: 0.01,
                                          on: .main,
                                          in: .default).autoconnect()
    
    @State private var volInc: Float = 0.1
    @State private var currentSample: Int = 0
    @State private var samples: [Float] = Array(repeating: 0, count: 8)
    @State private var player: AVAudioPlayer? = {
        let path = Bundle.main.path(forResource: "01-ACORDA-PEDRINHO", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)
        let player = try? AVAudioPlayer(contentsOf: url)
        player?.volume = 1
        player?.numberOfLoops = -1
        player?.isMeteringEnabled = true
        return player
    }()
    
    @Binding var shouldPlay: Bool
    var color: [Color]
    
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let val = (max(0.2, CGFloat(level) + 9) / 2) * CGFloat(abs(player?.volume ?? 1))
        if val > 1 { return 1 }
        
        return val
    }
    
    private func update() {
        guard let audio = player else { return }
        audio.updateMeters()
        
        withAnimation {
            self.samples[self.currentSample] = audio.volume < 0 ? 0 : audio.averagePower(forChannel: 0) * audio.volume
            self.currentSample = (self.currentSample + 1) % 8
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            HStack(alignment: .center) {
                ForEach(0..<8) { i in
                    Capsule().fill(color[i % 2])
                        .frame(width: proxy.size.width/8 - 8, height: proxy.size.height * normalizeSoundLevel(level: samples[i]) , alignment: .center)
                }
            }
            .onAppear {
                player?.play()
            }
            .onChange(of: shouldPlay) { shouldPlay in
                if shouldPlay {
                    player?.play()
                } else {
                    player?.pause()
                }
            }
            .onReceive(frequency) { _ in
                update()
            }
            
        }
    }
}
