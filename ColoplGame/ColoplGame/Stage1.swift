//
//  Stage1.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/17.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

// ステージ1のシーン
class Stage1: BaseStage {
    
    let motionManager = MyCMMotionManager()
    let playerBall = PlayerBall(circleOfRadius: 10)
    let goalArea = GoalArea(rectOfSize: CGSize(width: 50, height: 50))
    
    override init() {
        super.init()
        self.physicsWorld.contactDelegate = self
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        self.physicsWorld.contactDelegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        self.motionManager.startAccelerometerUpdate()
        
        self.configurePlayerBall()
        self.configureGoalArea()
    }
    
    func configurePlayerBall() {
        self.playerBall.configureBall()
        
        // ボールのスタートポジション(左下)
        let size = self.playerBall.frame.size
        let startPosition = CGPoint(x: size.width / 2, y: size.height / 2)
        self.playerBall.position = startPosition
        self.addChild(self.playerBall)
    }
    
    func configureGoalArea() {
        self.goalArea.configure()
        
        // ゴールエリアのポジション(右下)
        let size = self.goalArea.frame.size
        let pos = CGPoint(x: self.frame.size.width - (size.width / 2), y: size.height / 2)
        self.goalArea.position = pos
        self.addChild(self.goalArea)
    }
    
    func showClearLabel() {
        if (self.clearFlag) {
            return
        }

        self.clearFlag = true
        
        let clearLabel = ClearLabel(fontNamed: "Helvetica Bold")
        let size = self.frame.size
        let pos = CGPoint(x: size.width / 2, y: size.height / 2)
        clearLabel.position = pos
        self.addChild(clearLabel)
        
        let label = FadeInOutLabel(text: "Touch to Next Game!!!", fontName: "Helvetica")
        label.position = CGPoint(x: clearLabel.position.x, y: clearLabel.position.y - clearLabel.frame.size.height)
        self.addChild(label)
    }
    
    override func update(currentTime: NSTimeInterval) {
        self.playerBall.physicsBody?.applyImpulse(CGVector(dx: self.motionManager.accelerationX * 0.3, dy: 0))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (self.clearFlag) {
            self.changeSceneDelegate.changeScene(self)
            return
        }
        self.playerBall.jump()
    }
}

extension Stage1: SKPhysicsContactDelegate {
    func didBeginContact(contact: SKPhysicsContact) {
        print("nodeA = \(contact.bodyA.node?.name) nodeB = \(contact.bodyB.node?.name)")
        if ((contact.bodyA.node == self.playerBall && contact.bodyB.node == self.goalArea) || (contact.bodyA.node == self.goalArea && contact.bodyB.node == self.playerBall)) {
            self.showClearLabel()
            return
        }
        // 地面についたらダブルジャンプの回数をリセットする
        if ((contact.bodyA.node == self.playerBall && contact.bodyB.node == self) || (contact.bodyA.node == self && contact.bodyB.node == self.playerBall)) {
            self.playerBall.resetJumpCount()
        }
    }
}