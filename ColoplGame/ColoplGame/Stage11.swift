//
//  Stage11.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H28/01/02.
//  Copyright © 平成28年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class Stage11: BaseStage {
    
    var shouldThroughNumber = 1
    var checkFlagNum = 5 // 5コまで表示する
    var obstacle: Obstacle!
    var flag = CheckFlag()
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        self.setPlayerBallPosition()
        self.setGoalAreaPosition()
        self.setObstacle()
        self.setCheckFlag()
        self.physicsWorld.contactDelegate = self
    }
    
    override func update(currentTime: NSTimeInterval) {
        super.update(currentTime)
        
        if (self.shouldThroughNumber > self.checkFlagNum) {
            self.goalArea.hidden = false
            self.goalArea.physicsBody?.categoryBitMask = GameScene.ColliderType.GoalArea
            self.goalArea.physicsBody?.contactTestBitMask = GameScene.ColliderType.GoalArea
        }
    }
    
    func setPlayerBallPosition() {
        // ボールのスタートポジション(中央下)
        let size = self.playerBall.frame.size
        let pos = PositionHelper.getPosition(pos: .Lower, sourceView: self, size: size)
        self.playerBall.position = pos
        self.addChild(self.playerBall)
    }
    
    func setGoalAreaPosition() {
        // ゴールのポジション(中央)
        let size = self.goalArea.frame.size
        let pos = PositionHelper.getPosition(pos: .Center, sourceView: self, size: size)
        self.goalArea.position = pos
        self.addChild(self.goalArea)
        
        // 最初は非表示にしておく(チェックフラグを全て通ったら表示する)
        self.goalArea.hidden = true
        self.goalArea.physicsBody?.categoryBitMask = GameScene.ColliderType.None
        self.goalArea.physicsBody?.contactTestBitMask = GameScene.ColliderType.None
    }
    
    func setObstacle() {
        let size = CGSize(width: 50, height: 50)
        self.obstacle = Obstacle(rectOfSize: size)
        self.obstacle.configure()
        self.addChild(self.obstacle)
        self.moveUpAction() // 始めは下から上がっていく
    }
    
    func moveUpAction() {
        let moveUp = SKAction.moveToY(self.frame.size.height, duration: 3.0)
        let x = (Int)(arc4random_uniform(UInt32(self.frame.size.width)))
        self.obstacle.position = CGPoint(x: x, y: 0)
        self.obstacle.runAction(moveUp) {
            self.moveRightAction()
            self.setCheckFlag()
        }
    }
    
    func moveRightAction() {
        let moveRight = SKAction.moveToX(self.frame.size.width, duration: 3.0)
        let y = (Int)(arc4random_uniform(UInt32(self.frame.size.height / 4)))
        self.obstacle.position = CGPoint(x: 0, y: y)
        self.obstacle.runAction(moveRight) {
            self.moveUpAction()
            self.setCheckFlag()
        }
    }
    
    func setCheckFlag() {
        self.flag.removeFromParent()
        // 全てのチェックポイントを通過したらチェックポイントを表示しない
        if (self.shouldThroughNumber > self.checkFlagNum) {
            return
        }
        let size = CGSize(width: 50, height: 50)
        let texture = SKTexture(imageNamed: "\(self.shouldThroughNumber).jpg")
        self.flag = CheckFlag(texture: texture)
        self.flag.size = size
        self.flag.configure(self.shouldThroughNumber)
        self.flag.position = CGPoint(x: 0, y: 50)
        self.obstacle.addChild(self.flag)
    }
    
    override func didBeginContact(contact: SKPhysicsContact) {
        super.didBeginContact(contact)
        if ((contact.bodyA.node == self.playerBall && contact.bodyB.node == self.flag) || (contact.bodyA.node == self.flag && contact.bodyB.node == self.playerBall)) {
            
            if (self.shouldThroughNumber == flag.checkNumber) {
                    self.flag.collisionPlayerBall()
                    self.shouldThroughNumber++
            }
        }
    }
}