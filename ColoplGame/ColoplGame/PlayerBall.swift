//
//  PlayerBall.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/17.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class PlayerBall: SKShapeNode {
    
    private var jumpRestCount = 2
    private let jumpPower: CGFloat = 500
    
    let jumpSE = SKAction.playSoundFileNamed("jump.mp3", waitForCompletion: false)
    
    func configureBall() {
        self.fillColor = UIColor.redColor()
        self.strokeColor = UIColor.blackColor()
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        self.physicsBody?.categoryBitMask = GameScene.ColliderType.PlayerBall
        // ゲームシーンの周りのエリアと障害物との間で接触した際に反射動作を行う(つまりゴールエリアと接触した場合は反射動作せず、すり抜ける)
        self.physicsBody?.collisionBitMask = (GameScene.ColliderType.World | GameScene.ColliderType.Obstacle | GameScene.ColliderType.Ground | GameScene.ColliderType.LineObject)
        // 接触した場合にデリゲートメソッドを呼び出す対象のオブジェクトの指定
        self.physicsBody?.contactTestBitMask = (GameScene.ColliderType.GoalArea | GameScene.ColliderType.Obstacle | GameScene.ColliderType.Ground | GameScene.ColliderType.LineObject)
        
        self.name = "PlayerBall"
    }

    func jump() {
        if (self.jumpRestCount == 0) {
            return
        }
        //self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: self.jumpPower))
        self.physicsBody?.velocity.dy = self.jumpPower
        self.jumpRestCount--

        // ジャンプ音を再生する
        self.runAction(self.jumpSE)
    }
    
    func resetJumpCount(reset: Int = 2) {
        // まだ2回ジャンプが残ってるなら2回のままにする
        self.jumpRestCount = max(self.jumpRestCount, reset)
    }
}