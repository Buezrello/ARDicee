//
//  ViewController.swift
//  ARDicee
//
//  Created by Igor Gindin on 24/03/2018.
//  Copyright © 2018 Perfecto Mobile. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        // Set the view's delegate
        sceneView.delegate = self
        
////        let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
//
//        let sphere = SCNSphere(radius: 0.1)
//
//        let material = SCNMaterial()
//
////        material.diffuse.contents = UIColor.red
//
//        material.diffuse.contents = UIImage(named: "art.scnassets/moon.jpg")
//
////        cube.materials = [material]
//
//        sphere.materials = [material]
//
//        let node = SCNNode()
//
//        node.position = SCNVector3(x: 0, y: 0.1, z: -0.5)
//
////        node.geometry = cube
//
//        node.geometry = sphere
//
//        sceneView.scene.rootNode.addChildNode(node)
        
        sceneView.autoenablesDefaultLighting = true
        
//        // Create a new scene
//        let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
//
//        if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true) {
//            diceNode.position = SCNVector3(x: 0, y: 0, z: -0.1)
//            sceneView.scene.rootNode.addChildNode(diceNode)
//        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if ARWorldTrackingConfiguration.isSupported {
            // Create a session configuration
            let configuration = ARWorldTrackingConfiguration()
            
            configuration.planeDetection = .horizontal
            
            // Run the view's session
            sceneView.session.run(configuration)
        } else {
            let configuration = AROrientationTrackingConfiguration()
            
            sceneView.session.run(configuration)
        }
        
        print("Session is supported = \(AROrientationTrackingConfiguration.isSupported)")
        print("World Tracing is supported = \(ARWorldTrackingConfiguration.isSupported)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        if anchor is ARPlaneAnchor {
            
            let planeAnchor = anchor as! ARPlaneAnchor
            
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
            
            let planeNode = SCNNode()
            
            planeNode.position = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
            
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
            
            let gridMaterial = SCNMaterial()
            
            gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
            
            plane.materials = [gridMaterial]
            
            planeNode.geometry = plane
            
            node.addChildNode(planeNode)
            
        } else {
            return
        }
        
    }
    
}
