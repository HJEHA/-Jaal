//
//  FaceTrackingView.swift
//  DomainFaceTrackingInterface
//
//  Created by 황제하 on 3/29/24.
//

import SwiftUI
import Combine
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
      ),
      eyeBlink: viewStore.binding(
        get: \.eyeBlink,
        send: FaceTrackingStore.Action.eyeBlink
      )
    )
    .edgesIgnoringSafeArea(.all)
  }
}


// MARK: - View Container
private struct FaceTrackerViewContainer: UIViewRepresentable {
  @Binding var faceCenter: SIMD3<Float>?
  @Binding var eyeBlink: Float
  
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
    let coordinator = Coordinator(
      faceCenter: $faceCenter,
      eyeBlink: $eyeBlink
    )
    coordinator.bind()
    
    return coordinator
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
    @Binding var eyeBlink: Float
    
    private var cancellables = Set<AnyCancellable>()
    private(set) var eyeBlinkEvent = PassthroughSubject<Float, Never>()
    
    init(
      faceCenter: Binding<SIMD3<Float>?>,
      eyeBlink: Binding<Float>
    ) {
      _faceCenter = faceCenter
      _eyeBlink = eyeBlink
    }
    
    func bind() {
      eyeBlinkEvent
        .throttle(for: 0.2, scheduler: RunLoop.main, latest: false)
        .sink {
          self.eyeBlink = $0
        }
        .store(in: &cancellables)
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
      guard let faceAnchor = anchors.first as? ARFaceAnchor else { return }
      
      let x = faceAnchor.transform.columns.3.x
      let y = faceAnchor.transform.columns.3.y
      let z = faceAnchor.transform.columns.3.z
      faceCenter = SIMD3<Float>.init(x, y, z)
      
      let blendShapes = faceAnchor.blendShapes
      if let eyeBlinkLeft = blendShapes[.eyeBlinkLeft] as? Float,
         let eyeBlinkRight = blendShapes[.eyeBlinkRight] as? Float
      {
        if eyeBlinkLeft > 0.8 && eyeBlinkRight > 0.8 {
          eyeBlinkEvent.send(1)
        } else {
          eyeBlinkEvent.send(0)
        }
      }
    }
  }
}
