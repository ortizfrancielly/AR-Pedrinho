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
    var delegate: SessionDelegate
    
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
        arView.session.delegate = context.coordinator
        let anchor = AnchorEntity(.camera)
        arView.scene.anchors.append(anchor)
        context.coordinator.planeAnchor = anchor
        arView.session.run(configuration)
        return arView
        
    
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> SessionDelegate {
        delegate
    }
    
}


