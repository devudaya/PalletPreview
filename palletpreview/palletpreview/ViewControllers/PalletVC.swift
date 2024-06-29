//
//  PalletVC.swift
//  palletpreview
//
//  Created by Udaya Niroshana on 6/29/24.
//

import UIKit
import SceneKit

class PalletVC: UIViewController {
    
    @IBOutlet weak var scnView: SCNView!
    
    private let scene = SCNScene()
    var allBoxes: (small: Int, medium: Int, large: Int)!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpScnView()
        arrangeBoxes(small: allBoxes.small, medium: allBoxes.medium, large: allBoxes.large)
    }
    
    private func setUpScnView(){
        
        scnView.scene = self.scene
        scnView.allowsCameraControl = true
        scnView.autoenablesDefaultLighting = true
    }
    
    
    private func arrangeBoxes(small: Int, medium: Int, large: Int) {
        
          let scene = scnView.scene!
          scene.rootNode.childNodes.forEach { $0.removeFromParentNode() } // Clear previous nodes
          let palletSize = CGSize(width: 1.0, height: 1.0)
          let boxRatio = (small: 4, medium: 3, large: 2)
          let boxesPerLayer = 2
          let totalLayers = boxesPerLayer
          var remainingSmall = small
          var remainingMedium = medium
          var remainingLarge = large
        
          // Add pallet node
          let palletNode = createPalletNode(size: palletSize, color: .brown)
          scene.rootNode.addChildNode(palletNode)
        
          for layer in 0..<totalLayers {
              
            let layerNode = SCNNode()
            layerNode.position = SCNVector3(0, Float(layer) * 0.1 + 0.05, 0) // Adjust height per layer
              
            // Arrange 4 small boxes
            for i in 0..<boxRatio.small {
              let x = Float(i % 2) * 0.25 - 0.25 / 2
              let z = Float(i / 2) * 0.25 - 0.25 / 2
              let node = createBoxNode(size: CGSize(width: 0.25, height: 0.25), color: .red)
              node.position = SCNVector3(x, 0, z)
              layerNode.addChildNode(node)
              remainingSmall -= 1
            }
            // Arrange 3 medium boxes
            for i in 0..<boxRatio.medium {
              let x = Float(i % 3) * 0.33 - 0.33
              let z = 0.25 // Arrange medium boxes above small boxes
              let node = createBoxNode(size: CGSize(width: 0.33, height: 0.33), color: .blue)
              node.position = SCNVector3(Double(x), 0.0, z)
              layerNode.addChildNode(node)
              remainingMedium -= 1
            }
            // Arrange 2 large boxes
            for i in 0..<boxRatio.large {
              let x = Float(i % 2) * 0.5 - 0.5 / 2
              let z = 0.58 // Arrange large boxes above medium boxes
              let node = createBoxNode(size: CGSize(width: 0.5, height: 0.5), color: .green)
              node.position = SCNVector3(Double(x), 0.0, z)
              layerNode.addChildNode(node)
              remainingLarge -= 1
            }
            scene.rootNode.addChildNode(layerNode)
          }
        }
    
        private func createBoxNode(size: CGSize, color: UIColor) -> SCNNode {
          let box = SCNBox(width: size.width, height: 0.1, length: size.height, chamferRadius: 5)
          box.firstMaterial?.diffuse.contents = color
          return SCNNode(geometry: box)
        }
    
        private func createPalletNode(size: CGSize, color: UIColor) -> SCNNode {
          let pallet = SCNBox(width: size.width, height: 0.05, length: size.height, chamferRadius: 0)
          pallet.firstMaterial?.diffuse.contents = color
          let palletNode = SCNNode(geometry: pallet)
          palletNode.position = SCNVector3(0, 0.025, 0) // Center the pallet slightly above the ground
          return palletNode
        }
}
