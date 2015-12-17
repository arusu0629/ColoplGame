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
    
    var changeSceneDelegate: ChangeSceneProtocol!
    var clearFlag = false
    
    override init() {
        super.init()
        self.backgroundColor = UIColor.whiteColor()
        self.configureStage()
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = UIColor.whiteColor()
        self.configureStage()
    }
    
    func configureStage() {
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = GameScene.ColliderType.World
        self.name = "GameSceneArea"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}