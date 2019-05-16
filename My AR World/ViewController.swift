//
//  ViewController.swift
//  My AR World
//
//  Created by Toni Itkonen on 16/04/2019.
//  Copyright © 2019 Toni Itkonen. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    // OUTLETS
    @IBOutlet var sceneView: ARSCNView!
    
    // VARIABLES
    var sphere = SCNNode()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin,
                                  ARSCNDebugOptions.showFeaturePoints]
        
        // Adds lightning for your AR scene
        sceneView.autoenablesDefaultLighting = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session. Remember to call the function
        sceneView.session.run(configuration)
        drawSphereAtOrigin()
        drawBoxAt1200High()
        drawPyramidAt0600Low()
        drawPlaneAt900()
        drawTorusAt300()
        drawOrbitingShip()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // Draws an object to the scene
    func drawSphereAtOrigin() {
        sphere = SCNNode(geometry: SCNSphere(radius: 0.05))
        sphere.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "earth")
        sphere.geometry?.firstMaterial?.specular.contents = UIColor.yellow
        sphere.position = SCNVector3(0, 0, 0)
        sceneView.scene.rootNode.addChildNode(sphere)
        // Adding actions to the object
        let rotateAction = SCNAction.rotate(by: 360.degreesToRadians(), around: SCNVector3(0,1,0), duration: 8)
        let rotateForeverAction = SCNAction.repeatForever(rotateAction)
        sphere.runAction(rotateForeverAction)
    }
    
    func drawBoxAt1200High() {
        let box = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.0))
        // Defines box position with world origin
        box.position = SCNVector3(0, 0.2, -0.3)
        box.geometry?.firstMaterial?.diffuse.contents = UIColor.orange
        box.geometry?.firstMaterial?.specular.contents = UIColor.white
        // This will add it to the scene
        sceneView.scene.rootNode.addChildNode(box)
    }
    
    func drawPyramidAt0600Low() {
        let pyramid = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.1))
        // Defines pyramid position with world origin
        pyramid.position = SCNVector3(0, -0.2, 0.3)
        pyramid.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        pyramid.geometry?.firstMaterial?.specular.contents = UIColor.red
        
        // This will add it to the scene
        sceneView.scene.rootNode.addChildNode(pyramid)
    }
    
    func drawPlaneAt900() {
        let plane = SCNNode(geometry: SCNPlane(width: 0.1, height: 0.1))
        plane.position = SCNVector3(-0.2, 0, 0)
        plane.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "cat")
        plane.geometry?.firstMaterial?.isDoubleSided = true
        plane.eulerAngles = SCNVector3(-45.degreesToRadians(), 20.degreesToRadians(), 45.degreesToRadians())
        sceneView.scene.rootNode.addChildNode(plane)
    }
    
    func drawTorusAt300() {
        let torus = SCNNode(geometry: SCNTorus(ringRadius: 0.05, pipeRadius: 0.03))
        torus.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        torus.geometry?.firstMaterial?.specular.contents = UIColor.white
        torus.position = SCNVector3(0.2, 0, 0)
        // adds object to the angles
        torus.eulerAngles = SCNVector3(0, 0, 45.degreesToRadians())
        sceneView.scene.rootNode.addChildNode(torus)
    }
    
    func drawOrbitingShip() {
        // Imports AR asset from the AR asset folder
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        let ship = (scene.rootNode.childNode(withName: "ship", recursively: false))!
        ship.position = SCNVector3(1, 0, 0)
        ship.scale = SCNVector3(0.3, 0.3, 0.3)
        ship.eulerAngles = SCNVector3(0, 180.degreesToRadians(), 0)
        sphere.addChildNode(ship)
    }
   

    /* Specification:
     
     drawPlaneAt900
     euler angles
     45 degrees to clockwise x
     20 degrees to counterclockwise y
     45 degrees counterclockwise z
     
 */
    
    
    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

// EXTENSIONS

extension Int {
    func degreesToRadians() -> CGFloat {
        return CGFloat(self) * CGFloat.pi / 180.0
    }
}
