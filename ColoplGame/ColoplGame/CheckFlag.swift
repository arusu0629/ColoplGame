//
//  CheckFlag.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H28/01/02.
//  Copyright © 平成28年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class CheckFlag: SKSpriteNode {
    
    var checkNumber = 0
    var soundAction = SKAction.playSoundFileNamed("check.mp3", waitForCompletion: false)
    
    func configure(number: Int) {
        self.checkNumber = number
        self.zPosition = -5
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = GameScene.ColliderType.CheckFlag
        self.physicsBody?.contactTestBitMask = GameScene.ColliderType.PlayerBall
        self.name = "CheckFlag"
    }
    
    func collisionPlayerBall() {
        // チェックポイントを通過したSEを流す
        self.runAction(soundAction) {
            // SEを流し終えたらチェックラベルを削除する
            self.removeFromParent()
        }
    }
}