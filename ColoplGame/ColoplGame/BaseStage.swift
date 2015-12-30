//
//  BaseStage.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/17.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class BaseStage: SKScene {
    
    let motionManager = GameManager.motionManager
    let playerBall = PlayerBall(circleOfRadius: 10)
    let goalArea = GoalArea(rectOfSize: CGSize(width: 50, height: 50))
    let ground = SKShapeNode(rectOfSize: CGSize(width: 1000, height: 1))
    private var stageID = 1
    
    let clearSE = SKAction.playSoundFileNamed("clear.mp3", waitForCompletion: false)
        
    var changeSceneDelegate: ChangeSceneProtocol!
    var clearFlag = false
    var clearLabelTapped = false
    
    let paintManager = GameManager.paintManager
    
    override init() {
        super.init()
        self.backgroundColor = UIColor.whiteColor()
        self.physicsWorld.contactDelegate = self
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = UIColor.whiteColor()
        self.physicsWorld.contactDelegate = self
    }
    
    init(size: CGSize, id: Int) {
        super.init(size: size)
        self.stageID = id
        self.backgroundColor = UIColor.whiteColor()
        self.physicsWorld.contactDelegate = self
    }
        
    override func didMoveToView(view: SKView) {
        self.motionManager.startAccelerometerUpdate()
        self.configurePlayerBall()
        self.configureGoalArea()
        self.configureStage()
    }
    
    override func update(currentTime: NSTimeInterval) {
        // 力を加えないで速度で横移動を行うようにした
        let moveX = CGFloat(self.motionManager.accelerationX * 400)
        self.playerBall.physicsBody?.velocity.dx = moveX
        
        // 描画できるのは最大3つまで(4つからは古いやつが削除されていく)
        if (self.paintManager.lineObjects.count > self.paintManager.limitLineObjectNum) {
            let firstLineObject = self.paintManager.lineObjects.removeFirst()
            firstLineObject.removeFromParent()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (self.clearFlag && !clearLabelTapped) {
            self.motionManager.stopAccelerometerUpdates()
            self.clearLabelTapped = true
            NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "changeScene", userInfo: nil, repeats: false)
            return
        }
        self.paintManager.lastPoint = touches.first?.locationInNode(self)
        // ジャンプモードの場合はジャンプする
        if (GameViewController.jumpMode) {
            self.playerBall.jump()
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // ジャンプモードの時は描画処理はしないようにする
        if (GameViewController.jumpMode) {
            return
        }
        let newPoint = touches.first?.locationInNode(self)
        self.paintManager.lines.append(Line(start: self.paintManager.lastPoint, end: newPoint!))
        self.paintManager.lastPoint = newPoint
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // ジャンプモードの時は描画処理はしないようにする
        if (GameViewController.jumpMode) {
            return
        }
        
        // 指が離れた時に描画処理を行う
        let node = LineObject()
        node.path = self.paintManager.getPath()
        node.configure()
        
        self.addChild(node)
        self.paintManager.lineObjects.append(node)
    }
    
    func changeScene() {
        self.changeSceneDelegate.changeScene(self)
    }
    
    private func configurePlayerBall() {
        self.playerBall.configureBall()
    }
    
    private func configureGoalArea() {
        self.goalArea.configure()
    }
    
    private func configureStage() {
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = GameScene.ColliderType.World
        self.name = "GameSceneArea"
        
        self.ground.position = CGPoint(x: 0, y: 0)
        self.ground.physicsBody = SKPhysicsBody(rectangleOfSize: self.ground.frame.size)
        self.ground.physicsBody?.dynamic = false
        self.ground.physicsBody?.categoryBitMask = GameScene.ColliderType.Ground
        self.ground.name = "Ground"

        self.ground.removeFromParent() // you don't add it twice to its parent, SKScene
        
        self.addChild(ground)
    }
    
    // 子クラスのデリゲートメソッドの時の呼ばれる(ゴールエリアと衝突した時)
    private func showClearLabel() {
        if (self.clearFlag) {
            return
        }
        
        // ステージデータを更新する
        let data = StageClearData(id: self.stageID, isClear: true)
        data.id = self.stageID
        RealmHelper.update(data)
        
        self.clearFlag = true
        
        let clearLabel = ClearLabel(fontNamed: "Helvetica Bold")
        let size = self.frame.size
        let pos = CGPoint(x: size.width / 2, y: size.height / 2)
        clearLabel.position = pos
        self.addChild(clearLabel)
        
        let label = FadeInOutLabel(text: "Touch to Next Game!!!", fontName: "Helvetica")
        label.position = CGPoint(x: clearLabel.position.x, y: clearLabel.position.y - clearLabel.frame.size.height)
        self.addChild(label)
        
        // クリアSEを再生する
        self.runAction(self.clearSE)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BaseStage: SKPhysicsContactDelegate {
    func didBeginContact(contact: SKPhysicsContact) {
        print("nodeA = \(contact.bodyA.node?.name) nodeB = \(contact.bodyB.node?.name)")
        let success = (contact.bodyA.node == self.playerBall && contact.bodyB.node == self.goalArea) || (contact.bodyA.node == self.goalArea && contact.bodyB.node == self.playerBall)
        if (success) {
            self.showClearLabel()
            return
        }
        // 地面についたらダブルジャンプの回数をリセットする
        if ((contact.bodyA.node == self.playerBall && contact.bodyB.node?.name == "Ground") || (contact.bodyA.node?.name == "Ground" && contact.bodyB.node == self.playerBall)) {
            self.playerBall.resetJumpCount()
        }
        // ラインオブジェクトの場合はジャンプ回数を1にする
        if ((contact.bodyA.node == self.playerBall && contact.bodyB.node?.name == "LineObject") || (contact.bodyA.node?.name == "LineObject" && contact.bodyB.node == self.playerBall)) {
            self.playerBall.resetJumpCount(1)
        }
    }
}