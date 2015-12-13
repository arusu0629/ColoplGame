//
//  GameScene.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/13.
//  Copyright (c) 平成27年 ToruNakandakari. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let motionManager = MyCMMotionManager()
    // 自分が動かすボール
    let playerBall = SKShapeNode(circleOfRadius: 10)

    
    override func didMoveToView(view: SKView) {
        motionManager.startAccelerometerUpdate() // 加速度センサーを起動
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.0) // 重力の設定
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody?.dynamic = false
        self.physicsBody?.contactTestBitMask = 1
        
        self.configurePlayerBall()
    }
    
    func configurePlayerBall() {
        self.playerBall.fillColor = UIColor.redColor()
        self.playerBall.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        self.playerBall.position = CGPoint(x: self.playerBall.frame.size.width / 2, y: self.playerBall.frame.size.height / 2)
        self.playerBall.physicsBody?.contactTestBitMask = 1
        self.addChild(self.playerBall)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    }
   
    override func update(currentTime: CFTimeInterval) {
        self.playerBall.physicsBody?.velocity = CGVector(dx: self.motionManager.accelerationX * 500, dy: 0)
    }
    
    
    override init() {
        super.init()
        self.backgroundColor = UIColor.whiteColor()
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}