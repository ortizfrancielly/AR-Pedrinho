//
//  GameViewModel.swift
//  AR-Pedrinho
//
//  Created by Gabriel Ferreira de Carvalho on 07/06/22.
//
import ARKit
import Combine

final class GameViewModel: ObservableObject {
    @Published var frequency: Int
    @Published var time: Int
    @Published var shouldPlay: Bool
    @Published var isOpen: Bool
    @Published var isGameOver: Bool
    @Published var score: Int
    
    private var endGameCounter: Int
    private let endGameLimit: Int = 3
    
    var delegate: SessionDelegate
    
    private let timer = Timer.publish(every: 1,
                                      on: .main,
                                      in: .default)
    
    private var cancellables: Set<AnyCancellable>
    
    init() {
        self.frequency = .random(in: 4...10)
        self.time = 0
        self.shouldPlay = true
        self.score = 0
        self.isOpen = true
        self.isGameOver = false
        self.cancellables = Set<AnyCancellable>()
        self.endGameCounter = 0
        self.delegate = SessionDelegate()
    }
    
    func startStats() {
        self.time = 0
        self.shouldPlay = true
        self.score = 0
        self.isOpen = true
        self.isGameOver = false
        self.endGameCounter = 0
    }
    
    func startUp() {
        startStats()
        
        timer
            .autoconnect()
            .sink(receiveValue: update)
            .store(in: &cancellables)
        
        delegate
            .faceReadingPublisher
            .throttle(for: .seconds(1), scheduler: RunLoop.main, latest: true)
            .print()
            .map(isEyesOpen)
            .assign(to: &$isOpen)
        
        $shouldPlay
            .sink(receiveValue: delegate.updateAnchor)
            .store(in: &cancellables)
    }
    
    func finish() {
        cancellables.forEach { cancellable in
            cancellable.cancel()
        }
    }
    
    private func isEyesOpen(_ data: (left: Double, right: Double)) -> Bool {
        !(data.left >= 0.7 && data.right >= 0.7)
    }
    
    private func update(_ date: Date) {
        time += 1
        handleGameStatus()
        updateScore()
        handleEndGameCounterUpdate()
        generateHapticFeedbackWhenNecessary()
        handleEndGame()
        
        print("Is Eyes Open: \(isOpen)", "Should Play: \(shouldPlay)")
        print("time: \(time)", "frequency: \(frequency)")
    }
    
    private func generateHapticFeedbackWhenNecessary() {
        if !shouldPlay {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
    }
    
    private func handleGameStatus() {
        if time % frequency == 0 {
            shouldPlay.toggle()
            frequency = Int.random(in: 4...10)
            endGameCounter = 0
        }
    }
    
    private func updateScore() {
        if isOpen == shouldPlay {
            score += 1
        }
    }
    
    private func handleEndGameCounterUpdate() {
        if shouldEndGame(eyesStatus: isOpen, playStatus: shouldPlay) {
            endGameCounter += 1
        }
    }
    
    private func shouldEndGame(eyesStatus: Bool, playStatus: Bool) -> Bool {
        eyesStatus == true && playStatus == false
    }
    
    private func handleEndGame() {
        if shouldEndGame(eyesStatus: isOpen, playStatus: shouldPlay), endGameCounter == endGameLimit {
            isGameOver = true

        }
    }
    
}
