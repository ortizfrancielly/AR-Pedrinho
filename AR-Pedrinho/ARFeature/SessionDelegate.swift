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
    
    private func generatePedrinhoEntity(_ isPedrinhoAwake: Bool) -> Entity? {
        let entity: Entity?
        
        if isPedrinhoAwake {
            entity = try? Experience.loadPedrinhoAwake().pedrinho1
            entity?.position = SIMD3(-1.5, -1, -2)
        } else {
            entity = try? Experience.loadPedrinhoSleeping().pedrinho2
            entity?.position = SIMD3(0, -0.5, -2)
        }
        
        return entity
    }
    
    func updateAnchor (_ isPedrinhoAwake: Bool) {
        guard let planeAnchor = planeAnchor,
              let entity = generatePedrinhoEntity(isPedrinhoAwake)
        else {
            
            return }
        
        planeAnchor.children.forEach { entity in
            planeAnchor.removeChild(entity)
        }
        
        planeAnchor.addChild(entity)
    }
}
