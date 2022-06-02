//
//  ARViewContainer.swift
//  AR-Pedrinho
//
//  Created by Gabriel Ferreira de Carvalho on 02/06/22.
//

import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        let configuration = ARWorldTrackingConfiguration()
        
        guard ARWorldTrackingConfiguration.supportsUserFaceTracking else {
            return arView
        }
        
        arView.automaticallyConfigureSession = false
        configuration.planeDetection = [.horizontal]
        configuration.environmentTexturing = .automatic
        configuration.userFaceTrackingEnabled = true
        UIApplication.shared.isIdleTimerDisabled = true
        context.coordinator.arView = arView
        arView.session.delegate = context.coordinator
        
        let ballAnchor = try! Experience.loadBall()
        
        arView.session.run(configuration)
        
        arView.scene.anchors.append(ballAnchor)
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> SessionDelegate {
        SessionDelegate()
    }
    
}


