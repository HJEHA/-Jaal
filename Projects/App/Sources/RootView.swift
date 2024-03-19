import SwiftUI
import RealityKit

import ComposableArchitecture

struct RootView: View {
  public let store: StoreOf<RootStore>
  
  public init(store: StoreOf<RootStore>) {
    self.store = store
  }
  
  var body: some View {
    ARViewContainer().edgesIgnoringSafeArea(.all)
  }
}

struct ARViewContainer: UIViewRepresentable {
  
  func makeUIView(context: Context) -> ARView {
    
    let arView = ARView(frame: .zero)
    
    return arView
    
  }
  
  func updateUIView(_ uiView: ARView, context: Context) {}
  
}
