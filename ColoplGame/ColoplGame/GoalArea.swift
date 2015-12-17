//
//  GoalArea.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/17.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class GoalArea: SKShapeNode {
    
    func configure() {
        self.fillColor = UIColor.blueColor()
        self.strokeColor = UIColor.blackColor()
        self.physicsBody = SKPhysicsBody(rectangleOfSize:self.frame.size)
        self.zPosition = -1.0
        self.physicsBody?.dynamic = false // 重力などの影響を受けないようにする
        
        self.physicsBody?.categoryBitMask = GameScene.ColliderType.GoalArea
        // プレイヤーボールとの接触がされた際にデリゲートメソッドを呼び出す
        self.physicsBody?.contactTestBitMask = GameScene.ColliderType.PlayerBall
        self.name = "GoalArea"
    }
    
    func setPos(position: CGPoint) {
        self.position = position
    }
}
