//
//  Obstacle.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/18.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class Obstacle: SKShapeNode {
    
    var makeGround: Bool!
    
    func configure(makeGround makeGround: Bool = true) {
        self.makeGround = makeGround
        
        self.fillColor = UIColor.lightGrayColor()
        self.strokeColor = UIColor.blackColor()
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = GameScene.ColliderType.Obstacle
        self.physicsBody?.collisionBitMask = GameScene.ColliderType.GoalArea
        self.name = "Obstacle"
        
        self.createGround()
    }
    
    func createGround() {
        if (!self.makeGround) {
            return
        }        
        let ground = SKShapeNode(rectOfSize: CGSize(width: self.frame.size.width - 5, height: 1.0))
        ground.position = CGPoint(x: 0, y: self.frame.size.height / 2)
        ground.fillColor = UIColor.yellowColor()
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: ground.frame.size)
        ground.physicsBody?.dynamic = false
        ground.physicsBody?.categoryBitMask = GameScene.ColliderType.Ground
        ground.name = "Ground"
        
        ground.removeFromParent()
        self.addChild(ground)
    }
}