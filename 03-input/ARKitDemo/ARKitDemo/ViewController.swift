//
//  ViewController.swift
//  ARKitDemo
//
//  Created by Jon Manning on 1/2/18.
//  Copyright © 2018 Jon Manning. All rights reserved.
//

import UIKit
import ARKit

// BEGIN arkit_vc
class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        guard let scene = SCNScene(named: "Cube.scn") else {
            fatalError("Failed to load scene!")
        }
        
        sceneView.scene = scene
        
        sceneView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        
        sceneView.session.run(configuration)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }

    // BEGIN arkit_hittest
    @IBAction func sceneTapped(_ sender: UITapGestureRecognizer) {
        
        // Get the location of the touch in the view
        let touchLocation = sender.location(ofTouch: 0, in: sceneView)
        
        print("Tapped at \(touchLocation)")
        
        // Find all horizontal planes at this touch location
        let hitLocations = sceneView.hitTest(touchLocation,
                                             types: .estimatedHorizontalPlane)
        
        guard let firstLocation = hitLocations.first else {
            print("Didn't find a hit location")
            return
        }
        
        // Find the first node named 'box'; we'll make a copy of it
        guard let cube = sceneView.scene.rootNode
            .childNode(withName: "box", recursively: false) else {
                
            print("Error: couldn't find the box?")
            return
        }
        
        // Create a copy of that cube and add it to the scene
        let newCube = cube.clone()
        sceneView.scene.rootNode.addChildNode(newCube)
        
        // Convert the position and orientation of the plane to a
        // type that SceneKit can use
        let newCubeTransform = SCNMatrix4(firstLocation.worldTransform)
        
        // Set this position and orientation
        newCube.setWorldTransform(newCubeTransform)
        
    }
    // END arkit_hittest
    
}
// END arkit_vc
