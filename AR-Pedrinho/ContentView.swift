//
//  ContentView.swift
//  AR-Pedrinho
//
//  Created by Francielly Cristina Ortiz Candido on 02/06/22.
//

import SwiftUI
import RealityKit
import SceneKit

struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}



#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
