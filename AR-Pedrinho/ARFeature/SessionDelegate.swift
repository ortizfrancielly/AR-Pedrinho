//
//  SessionDelegate.swift
//  AR-Pedrinho
//
//  Created by Gabriel Ferreira de Carvalho on 02/06/22.
//

import ARKit
import Combine
import RealityKit

class SessionDelegate: NSObject, ARSessionDelegate {
    var counter: Int = 0
    weak var planeAnchor: AnchorEntity?
    
    private let faceReadingSubject: PassthroughSubject<(left: Double, right: Double), Never> = .init()
    
    var faceReadingPublisher: AnyPublisher<(left: Double, right: Double), Never> {
        faceReadingSubject.eraseToAnyPublisher()
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        print(anchors)
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        
        anchors
            .compactMap { $0 as? ARFaceAnchor }
            .forEach { faceAnchor in
                if let left = faceAnchor.blendShapes[.eyeBlinkLeft]?.doubleValue,
                   let right = faceAnchor.blendShapes[.eyeBlinkRight]?.doubleValue {
                    faceReadingSubject.send((left: left, right: right))
                }
                
            }
    }
    
    func updateAnchor (_ isPedrinhoAwake: Bool) {
        guard let planeAnchor = planeAnchor,
        let entity = isPedrinhoAwake ?
        try? Experience.loadPedrinhoAwake().pedrinho1 :
        try? Experience.loadPedrinhoSleeping().pedrinho2
        else { return }
        
        planeAnchor.children.forEach { entity in
            planeAnchor.removeChild(entity)
        }
        
        planeAnchor.addChild(entity)
    }
}
