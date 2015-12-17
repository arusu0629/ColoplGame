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
    
    func configureBall() {
        self.fillColor = UIColor.redColor()
        self.strokeColor = UIColor.blackColor()
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        self.physicsBody?.categoryBitMask = GameScene.ColliderType.PlayerBall
        // ゲームシーンの周りのエリアと障害物との間で接触した際に反射動作を行う(つまりゴールエリアと接触した場合は反射動作せず、すり抜ける)
        self.physicsBody?.collisionBitMask = (GameScene.ColliderType.World | GameScene.ColliderType.Other)
        // ゴールエリアと障害物と接触した場合にデリゲートメソッドを呼び出す対象のオブジェクトの指定
        self.physicsBody?.contactTestBitMask = (GameScene.ColliderType.GoalArea | GameScene.ColliderType.Other | GameScene.ColliderType.World)
        
        self.name = "PlayerBall"
    }
    
    func setStartPosition(postion: CGPoint) {
        self.position = position
    }
}