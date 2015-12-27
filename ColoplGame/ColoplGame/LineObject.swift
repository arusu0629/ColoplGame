//
//  LineObject.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/27.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class LineObject: SKShapeNode {
    func configure() {
        self.strokeColor = UIColor.greenColor()
        self.lineWidth = 3
        self.physicsBody = SKPhysicsBody(polygonFromPath: self.path!)
        self.physicsBody?.dynamic = false
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.categoryBitMask = GameScene.ColliderType.LineObject
        self.name = "LineObject"
    }
}
    