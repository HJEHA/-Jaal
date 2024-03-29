//
//  FaceTrackingView.swift
//  DomainFaceTrackingInterface
//
//  Created by 황제하 on 3/29/24.
//

import SwiftUI

import RealityKit
import ARKit

import ComposableArchitecture

public struct FaceTrackingView: View {
  public let store: StoreOf<FaceTrackingStore>
  @ObservedObject private var viewStore: ViewStoreOf<FaceTrackingStore>
  
  public init(store: StoreOf<FaceTrackingStore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  public var body: some View {
    FaceTrackerViewContainer(
      faceCenter: viewStore.binding(
        get: \.faceCenter,
        send: FaceTrackingStore.Action.changedFaceCenter
      )
    )
    .edgesIgnoringSafeArea(.all)
  }
}


// MARK: - View Container
private struct FaceTrackerViewContainer: UIViewRepresentable {
  @Binding var faceCenter: SIMD3<Float>?
  
  func makeUIView(context: Context) -> ARView {
    let arView = ARView(frame: .zero)
    let configuration = ARFaceTrackingConfiguration()
    configuration.maximumNumberOfTrackedFaces = 1
    arView.session.run(
      configuration,
      options: [.resetTracking, .removeExistingAnchors]
    )
    arView.scene.addAnchor(faceAnchor())
    
    arView.session.delegate = context.coordinator
    
    return arView
  }
  
  func updateUIView(_ uiView: ARView, context: Context) {}
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(faceCenter: $faceCenter)
  }
  
  func faceAnchor() -> AnchorEntity {
    let faceAnchor = AnchorEntity(.face)
    let faceNode = createFaceNode()
    faceAnchor.addChild(faceNode)
    return faceAnchor
  }
  
  func createFaceNode() -> Entity {
    let faceNode = Entity()
    
    // TODO: 얼굴 모양 캐릭터로 이미지 교체
    let plane = MeshResource.generatePlane(width: 0.2, height: 0.2)
    let material = SimpleMaterial(color: .white, isMetallic: false)
    let planeModel = ModelComponent(mesh: plane, materials: [material])
    faceNode.components.set(planeModel)
    
    faceNode.position = [0, 0, 0.1]
    
    return faceNode
  }
  
  class Coordinator: NSObject, ARSessionDelegate {
    @Binding var faceCenter: SIMD3<Float>?
    
    init(faceCenter: Binding<SIMD3<Float>?>) {
      _faceCenter = faceCenter
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
      guard let faceAnchor = anchors.first as? ARFaceAnchor else { return }
      
      faceCenter = faceAnchor.lookAtPoint
      
      //TODO: - Eye 트래킹
      //let blendShapes = faceAnchor.blendShapes
      //if let eyeBlinkLeft = blendShapes[.eyeBlinkLeft] as? Float,
      //   let eyeBlinkRight = blendShapes[.eyeBlinkRight] as? Float
      //{
      //
      //}
    }
  }
}
