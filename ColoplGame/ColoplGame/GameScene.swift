//
//  GameScene.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/13.
//  Copyright (c) 平成27年 ToruNakandakari. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    struct ColliderType {
        static let PlayerBall: UInt32 = (1 << 0)
        static let GoalArea: UInt32 = (1 << 1)
        static let World: UInt32 = (1 << 2)
        static let Other: UInt32 = (1 << 3)
        static let None: UInt32 = (1 << 4)
    }
    
    let motionManager = MyCMMotionManager()
    // 自分が動かすボール
    let playerBall = SKShapeNode(circleOfRadius: 10)
    // ゴールエリア
    let goalArea = SKShapeNode(rectOfSize: CGSize(width: 50, height: 50))
    // クリアフラグ
    var clearFlag = false

    
    override func didMoveToView(view: SKView) {
        motionManager.startAccelerometerUpdate() // 加速度センサーを起動
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.0) // 重力の設定
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = ColliderType.World
        self.physicsWorld.contactDelegate = self
        self.name = "Game Scene Area"
        
        // 自分が動かすボールの初期設定を行う
        self.configurePlayerBall()
        
        // ゴールエリアを作成する
        self.configureGoalArea()
    }
    
    func configurePlayerBall() {
        self.playerBall.fillColor = UIColor.redColor()
        self.playerBall.strokeColor = UIColor.blackColor()
        self.playerBall.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        self.playerBall.position = CGPoint(x: self.playerBall.frame.size.width / 2, y: self.playerBall.frame.size.height / 2)
        self.playerBall.physicsBody?.categoryBitMask = ColliderType.PlayerBall
        // ゲームシーンの周りのエリアと障害物との間で接触した際に反射動作を行う(つまりゴールエリアと接触した場合は反射動作せず、すり抜ける)
        self.playerBall.physicsBody?.collisionBitMask = (ColliderType.World | ColliderType.Other)
        // ゴールエリアと障害物と接触した場合にデリゲートメソッドを呼び出す対象のオブジェクトの指定
        self.playerBall.physicsBody?.contactTestBitMask = (ColliderType.GoalArea | ColliderType.Other)
        
        self.playerBall.name = "Player Ball"
        self.addChild(self.playerBall)
    }
    
    func configureGoalArea() {
        self.goalArea.fillColor = UIColor.blueColor()
        self.goalArea.strokeColor = UIColor.blackColor()
        self.goalArea.physicsBody = SKPhysicsBody(rectangleOfSize: self.goalArea.frame.size)
        self.goalArea.position = CGPoint(x: (self.frame.size.width - self.goalArea.frame.size.width / 2.0), y: (self.goalArea.frame.size.height / 2.0)) // 画面右下に配置
        self.goalArea.zPosition = -1.0
        self.goalArea.physicsBody?.dynamic = false // 重力などの影響を受けないようにする

        self.goalArea.physicsBody?.categoryBitMask = ColliderType.GoalArea
        // プレイヤーボールとの接触がされた際にデリゲートメソッドを呼び出す
        self.goalArea.physicsBody?.contactTestBitMask = ColliderType.PlayerBall
        self.goalArea.name = "Goal Area"
        self.addChild(self.goalArea)
    }
    
    func showClearLabel() {
        // すでにクリアされている場合は何もしない
        if (self.clearFlag) {
            return
        }
        
        // クリアフラグを立てる
        self.clearFlag = true
        
        // クリアラベルを表示
        let clearLabel = SKLabelNode(fontNamed: "Helvetica Bold")
        clearLabel.fontSize = 60
        clearLabel.fontColor = UIColor.redColor()
        clearLabel.position = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0)
        clearLabel.zPosition = 100
        clearLabel.text = "Clear!!!"
        self.addChild(clearLabel)
        
        // ラベルの下にフェードイン/アウトを繰り返した小さなラベルを表示
        let label = SKLabelNode(fontNamed: "Helvetica")
        label.fontSize = 20
        label.fontColor = UIColor.blackColor()
        label.position = CGPoint(x: clearLabel.position.x, y: clearLabel.position.y - clearLabel.frame.size.height)
        label.zPosition = 100
        label.text = "Touch to Next Game!!!"
        
        let fadeOut = SKAction.fadeAlphaTo(0, duration: 0.7)
        let fadeIn = SKAction.fadeAlphaTo(1, duration: 0.7)
        let repeatAction = SKAction.repeatActionForever(SKAction.sequence([fadeOut, fadeIn]))
        label.runAction(repeatAction)
        
        self.addChild(label)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("GameScene Now!!!")
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

extension GameScene: SKPhysicsContactDelegate {
    func didBeginContact(contact: SKPhysicsContact) {
        print("nodeA = \(contact.bodyA.node?.name) nodeB = \(contact.bodyB.node?.name)")
        if ((contact.bodyA.node == self.playerBall && contact.bodyB.node == self.goalArea) || (contact.bodyA.node == self.goalArea || contact.bodyB.node == self.playerBall)) {
            self.showClearLabel()
            return
        }
    }
}