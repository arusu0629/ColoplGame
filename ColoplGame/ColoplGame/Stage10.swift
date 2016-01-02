//
//  Stage10.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H28/01/02.
//  Copyright © 平成28年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

// チェックフラグが登場するステージ
class Stage10: BaseStage {
    
    var shouldThroughNumber = 1
 
    var obstacle1: Obstacle!
    var obstacle2: Obstacle!
    var obstacle3: Obstacle!
    
    var checkFlags: [CheckFlag] = []
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        self.setPlayerBallPosition()
        self.setGoalAreaPosition()
        self.setObstacle()
        self.setCheckFlags()
        self.setHintLabel()
        self.physicsWorld.contactDelegate = self
    }
    
    override func update(currentTime: NSTimeInterval) {
        super.update(currentTime)
        
        // 全てのチェックポイントを通過したらゴールエリアを表示する
        if (self.shouldThroughNumber == self.checkFlags.count + 1) {
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
        // ゴールのポジション(左下)
        let size = self.goalArea.frame.size
        let pos = PositionHelper.getPosition(pos: .LowerLeft, sourceView: self, size: size)
        self.goalArea.position = pos
        self.addChild(self.goalArea)

        // 最初は非表示にしておく(チェックフラグを全て通ったら表示する)
        self.goalArea.hidden = true
        self.goalArea.physicsBody?.categoryBitMask = GameScene.ColliderType.None
        self.goalArea.physicsBody?.contactTestBitMask = GameScene.ColliderType.None
    }
    
    func setObstacle() {
        let size = CGSize(width: 50, height: 50)
        var pos = PositionHelper.getPosition(pos: .UpperLeft, sourceView: self, size: size)
        self.obstacle1 = Obstacle(rectOfSize: size)
        self.obstacle1.position = pos
        self.obstacle1.configure()
        
        pos = PositionHelper.getPosition(pos: .LowerRight, sourceView: self, size: size)
        self.obstacle2 = Obstacle(rectOfSize: size)
        self.obstacle2.position = pos
        self.obstacle2.configure()
        
        pos = PositionHelper.getPosition(pos: .Center, sourceView: self, size: size)
        self.obstacle3 = Obstacle(rectOfSize: size)
        self.obstacle3.position = pos
        self.obstacle3.configure()
        
        self.addChild(self.obstacle1)
        self.addChild(self.obstacle2)
        self.addChild(self.obstacle3)
        
        let moveUp = SKAction.moveToY(self.frame.size.height - self.obstacle1.frame.size.height, duration: 1.5)
        let moveCenter = SKAction.moveToY(self.frame.size.height / 2, duration: 1.5)
        let moveDown = SKAction.moveToY(0, duration: 1.5)
        let repeatAction1 = SKAction.repeatActionForever(SKAction.sequence([moveCenter, moveUp]))
        let repeatAction2 = SKAction.repeatActionForever(SKAction.sequence([moveCenter, moveDown]))
        
        self.obstacle1.runAction(repeatAction1)
        self.obstacle2.runAction(repeatAction2)
    }
    
    func setCheckFlags() {
        let size = CGSize(width: 50, height: 50)
        for (var i = 1; i <= 3; i++) {
            let texture = SKTexture(imageNamed: "\(i).jpg")
            let flag = CheckFlag(texture: texture)
            flag.size = size
            flag.configure(i)
            flag.position = CGPoint(x: 0, y: 50)
            self.checkFlags.append(flag)
        }
        self.obstacle1.addChild(self.checkFlags[0])
        self.obstacle2.addChild(self.checkFlags[1])
        self.obstacle3.addChild(self.checkFlags[2])
    }
    
    func setHintLabel() {
        let text1 = "各チェックポイントを順番よく通ろう"
        let text2 = "全て通るとゴールエリアが表示されるぞ!"
        let label = HintLabel(texts: text1, text2)
        let size = label.frame.size
        let pos = CGPoint(x: (self.frame.size.width / 2) - (size.width / 2), y: self.frame.size.height - (size.height * 2))
        label.position = pos
        self.addChild(label)
        label.startAction()
    }
    
    override func didBeginContact(contact: SKPhysicsContact) {
        super.didBeginContact(contact)
        
        if ((contact.bodyA.node == self.playerBall && contact.bodyB.node?.name == "CheckFlag") || (contact.bodyA.node?.name == "CheckFlag" && contact.bodyB.node == self.playerBall)) {
            
            if let flag = contact.bodyA.node as? CheckFlag {
                if (self.shouldThroughNumber == flag.checkNumber) {
                    flag.collisionPlayerBall()
                    self.shouldThroughNumber++
                    return
                }
            }
            
            if let flag = contact.bodyB.node as? CheckFlag {
                if (self.shouldThroughNumber == flag.checkNumber) {
                    flag.collisionPlayerBall()
                    self.shouldThroughNumber++
                }
            }
        }
    }
}

