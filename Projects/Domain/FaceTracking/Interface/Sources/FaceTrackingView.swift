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

import SharedDesignSystem
import CoreUserDefaults

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
    .onChange(of: store.isSnapshot) { oldValue, newValue in
      if newValue == true {
        ARVariables.arView.snapshot(saveToHDR: false) { image in
          store.send(.saveImage(image))
        }
      }
    }
  }
}

struct ARVariables{
  static var arView: ARView!
}

// MARK: - View Container
private struct FaceTrackerViewContainer: UIViewRepresentable {
  @Binding var faceCenter: SIMD3<Float>?
  @Binding var eyeBlink: Float
  
  func makeUIView(context: Context) -> ARView {
    ARVariables.arView = ARView(frame: .zero)
    let configuration = ARFaceTrackingConfiguration()
    configuration.maximumNumberOfTrackedFaces = 1
    ARVariables.arView.session.run(
      configuration,
      options: [.resetTracking, .removeExistingAnchors]
    )
    ARVariables.arView.scene.addAnchor(faceAnchor())
    
    ARVariables.arView.session.delegate = context.coordinator
    
    return ARVariables.arView
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
    let faceNode = createFaceNode(
      "faceTexture\(JaalUserDefaults.faceID)"
    )
    let headNode = createFaceNode(
      "headTexture\(JaalUserDefaults.headID)"
    )
    faceAnchor.addChild(headNode)
    faceAnchor.addChild(faceNode)
    return faceAnchor
  }
  
  func createFaceNode(_ name: String) -> Entity {
    let faceNode = Entity()
    
    let plane = MeshResource.generatePlane(
      width: 0.3,
      height: 0.3
    )
    let material = createMaterial(name)
    let planeModel = ModelComponent(
      mesh: plane,
      materials: [material]
    )
    faceNode.components.set(planeModel)
    
    faceNode.position = [-0.01, 0.03, 0.07]
    return faceNode
  }
  
  func createMaterial(_ name: String) -> SimpleMaterial {
    let color = SkinColors.allCases[JaalUserDefaults.skinID].color
    var material = SimpleMaterial()
    material.color = .init(
      tint: color.withAlphaComponent(0.999),
      texture: .init(
        try! .load(
          named: name,
          in: SharedDesignSystemResources.bundle
        )
      )
    )
    material.metallic = .float(0)
    material.roughness = .float(1.0)
    
    return material
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
