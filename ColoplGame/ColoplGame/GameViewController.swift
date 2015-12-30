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
    
    private var myLeftButton: UIBarButtonItem!
    private var myRightButton: UIBarButtonItem!
    private var centerButton: UIButton!
    
    static var jumpMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gameView = self.view as! SKView
        self.gameView.backgroundColor = UIColor.whiteColor()
        
        self.configureNavigationBar()
        
        // ナビゲーションバーを非表示する
        self.navigationController?.navigationBarHidden = true
        
        self.switchingStartScene()
    }
    
    func configureNavigationBar() {
        self.myLeftButton = UIBarButtonItem(title: "Replay", style: .Plain, target: self, action: "replay")
        self.myRightButton = UIBarButtonItem(title: "Exit", style: .Plain, target: self, action: "exit")
        self.navigationItem.leftBarButtonItem = self.myLeftButton
        self.navigationItem.rightBarButtonItem = self.myRightButton
        
        // ナビゲーションバー中央にジャンプ,描画モードを切り替えるボタンを配置する
        self.centerButton = UIButton(type: .Custom)
        self.centerButton.frame = CGRectMake(0, 0, 40, 40)
        self.centerButton.setImage(UIImage(named: "Jump.jpg"), forState: .Normal)
        self.centerButton.setTitle("Jump", forState: .Normal)
        self.centerButton.addTarget(self, action: "changeIcon:", forControlEvents: .TouchUpInside)
        self.navigationItem.titleView = centerButton
    }
    
    func changeIcon(sender: UIButton) {
        if (sender.titleLabel?.text == "Jump") {
            sender.setImage(UIImage(named: "Paint.jpg"), forState: .Normal)
            sender.setTitle("Paint", forState: .Normal)
            GameViewController.jumpMode = false
            return
        }
        sender.setImage(UIImage(named: "Jump.jpg"), forState: .Normal)
        sender.setTitle("Jump", forState: .Normal)
        GameViewController.jumpMode = true
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
        // ゲーム中にはナビゲーションバーを表示する
        self.navigationController?.navigationBarHidden = false
        // ナビゲーションバーのボタンを有効にする
        self.myLeftButton.enabled = true
        self.myRightButton.enabled = true
    }
    
    func replay() {
        // ゲーム画面を再ロードする
        self.switchingGameScene()
        self.resetCenterButton()
    }
    
    func exit() {
        // ステージ選択画面に戻る
        self.switchingStageSelectScene()
        // ナビゲーションバーのボタンを無効にする
        self.myLeftButton.enabled = false
        self.myRightButton.enabled = false
    }
    
    func resetCenterButton() {
        self.centerButton.setImage(UIImage(named: "Jump.jpg"), forState: .Normal)
        self.centerButton.setTitle("Jump", forState: .Normal)
        GameViewController.jumpMode = true
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
