//
//  SessionDelegate.swift
//  AR-Pedrinho
//
//  Created by Gabriel Ferreira de Carvalho on 02/06/22.
//

import ARKit
import RealityKit

class SessionDelegate: NSObject, ARSessionDelegate {
    
    weak var arView: ARView?
    var counter: Int = 0
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        
        anchors
            .compactMap { $0 as? ARFaceAnchor }
            .forEach { faceAnchor in
                if faceAnchor.blendShapes[.eyeBlinkLeft]?.doubleValue ?? 0 > 0.8 && faceAnchor.blendShapes[.eyeBlinkRight]?.doubleValue ?? 0 > 0.8 {
                    counter += 1
                    //print("eyes are closed")
                } else {
                    counter -= 1
                    //print("eyes are open")
                }
            }
    }
}
