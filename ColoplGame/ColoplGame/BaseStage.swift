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
    
    let motionManager = MyCMMotionManager()
    let playerBall = PlayerBall(circleOfRadius: 10)
    let goalArea = GoalArea(rectOfSize: CGSize(width: 50, height: 50))
    let ground = SKShapeNode(rectOfSize: CGSize(width: 1000, height: 1))
    
    let clearSE = SKAction.playSoundFileNamed("clear.mp3", waitForCompletion: false)
    
    private var stageID = 1
    
    var changeSceneDelegate: ChangeSceneProtocol!
    var clearFlag = false
    var clearLabelTapped = false
    
    override init() {
        super.init()
        self.backgroundColor = UIColor.whiteColor()
        self.physicsWorld.contactDelegate = self
        self.configureStage()
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = UIColor.whiteColor()
        self.physicsWorld.contactDelegate = self
        self.configureStage()
    }
    
    init(size: CGSize, id: Int) {
        super.init(size: size)
        self.stageID = id
        self.backgroundColor = UIColor.whiteColor()
        self.physicsWorld.contactDelegate = self
        self.configureStage()
    }

    
    override func didMoveToView(view: SKView) {
        self.motionManager.startAccelerometerUpdate()
        self.configurePlayerBall()
        self.configureGoalArea()
    }
    
    override func update(currentTime: NSTimeInterval) {
//        self.playerBall.physicsBody?.applyImpulse(CGVector(dx: self.motionManager.accelerationX * 0.3, dy: 0))

        // 力を加えないで速度で横移動を行うようにした
        let moveX = CGFloat(self.motionManager.accelerationX * 400)
        self.playerBall.physicsBody?.velocity.dx = moveX
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (self.clearFlag && !clearLabelTapped) {
            self.clearLabelTapped = true
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "changeScene", userInfo: nil, repeats: false)
            return
        }
        self.playerBall.jump()
    }
    
    func changeScene() {
        self.changeSceneDelegate.changeScene(self)
    }
    
    func configurePlayerBall() {
        self.playerBall.configureBall()
    }
    
    func configureGoalArea() {
        self.goalArea.configure()
    }
    
    func configureStage() {
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
    func showClearLabel() {
        if (self.clearFlag) {
            return
        }
        
        // ステージデータを更新する
        let data = StageClearData()
        data.id = self.stageID
        data.isClear = true
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
    }
}