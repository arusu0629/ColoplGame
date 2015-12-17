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
    
    var gameView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gameView = self.view as! SKView
        self.gameView.backgroundColor = UIColor.whiteColor()
        self.switchingStartScene()
    }
    
    func switchingStartScene() {
        let scene = SceneManager.startScene(self.view.bounds.size)
        scene.changeSceneDelegate = self
        SceneManager.changeScene(self.gameView, New: scene, Duration: 0.5)
    }
    
    func switchingStageSelectScene() {
        let scene = SceneManager.stageSelectScene(self.view.bounds.size)
        scene.changeSceneDelegate = self
        SceneManager.changeScene(self.gameView, New: scene, Duration: 0.5)
    }
    
    func switchingGameScene() {
        let scene = SceneManager.stageScene(self.view.bounds.size)
        scene.changeSceneDelegate = self
        SceneManager.changeScene(self.gameView, New: scene, Duration: 0.5)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)        
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

extension GameViewController: ChangeSceneProtocol {
    func changeScene(scene: SKScene) {
        if (scene.isKindOfClass(StartScene)) {
            self.switchingStageSelectScene()
            return
        }
        if (scene.isKindOfClass(StageSelectScene)) {
            self.switchingGameScene()
            return
        }
        if (scene.isKindOfClass(GameScene)) {
            self.switchingStageSelectScene()
            return
        }
        if (scene.isKindOfClass(BaseStage)) {
            self.switchingStageSelectScene()
            return
        }
    }
}
