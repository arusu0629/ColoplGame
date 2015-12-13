//
//  GameViewController.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/13.
//  Copyright (c) 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()    
        
        let scene = GameScene()
        scene.scaleMode = .AspectFill
        
        let view = self.view as! SKView

        scene.size = view.frame.size
        view.presentScene(scene)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
