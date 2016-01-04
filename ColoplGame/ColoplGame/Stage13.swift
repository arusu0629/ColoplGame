//
//  Stage13.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H28/01/03.
//  Copyright © 平成28年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class Stage13: BaseStage {

    var fallenObstacle1: FallenObstacle!
    var fallenObstacle2: FallenObstacle!
    var fallenObstacle3: FallenObstacle!
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        self.setPlayerBall()
        self.setGoalArea()
        self.setObstacle()
        self.setHintLabel()
        self.physicsWorld.contactDelegate = self
    }
    
    func setPlayerBall() {
        let size = self.playerBall.frame.size
        // スタートポジション(左下)
        let pos = PositionHelper.getPosition(pos: .LowerLeft, sourceView: self, size: size)
        self.playerBall.position = pos
        self.addChild(self.playerBall)
    }
    
    func setGoalArea() {
        let size = self.goalArea.frame.size
        // ゴールポジション(右上)
        let pos = PositionHelper.getPosition(pos: .UpperRight, sourceView: self, size: size)
        self.goalArea.position = pos
        self.addChild(self.goalArea)
    }
    
    func setObstacle() {
        let size = CGSize(width: 40, height: 40)
        let center = PositionHelper.getPosition(pos: .Center, sourceView: self, size: size)
        
        self.fallenObstacle1 = FallenObstacle(rectOfSize: size)
        self.fallenObstacle1.configure(makeGround: true)
        self.fallenObstacle1.position = center
        self.addChild(self.fallenObstacle1)
        
        // 中央から見て左下の障害物
        var pos = CGPointMake(center.x / 2.0, center.y / 2.0)
        self.fallenObstacle2 = FallenObstacle(rectOfSize: size)
        self.fallenObstacle2.configure(makeGround: true)
        self.fallenObstacle2.position = pos
        self.addChild(self.fallenObstacle2)
        
        // 中から見て右上の障害物
        pos = CGPointMake(center.x + center.x / 2.0, center.y + center.y / 2.0)
        self.fallenObstacle3 = FallenObstacle(rectOfSize: size)
        self.fallenObstacle3.configure(makeGround: true)
        self.fallenObstacle3.position = pos
        self.addChild(self.fallenObstacle3)
    }
    
    func setHintLabel() {
        let text = "むらさき色の障害物に乗ると落ちるぞ!"
        let label = HintLabel(text: text)
        let size = label.frame.size
        let pos = CGPoint(x: (self.frame.size.width / 2) - (size.width / 2), y: self.frame.size.height - (size.height * 2))
        label.position = pos
        self.addChild(label)
        label.startAction()
    }
    
    override func didBeginContact(contact: SKPhysicsContact) {
        super.didBeginContact(contact)
        
        // 落ちる障害物と接触した場合の処理
        if ((contact.bodyA.node == self.playerBall && contact.bodyB.node == "Fallen Ground") || (contact.bodyA.node?.name == "Fallen Ground" && contact.bodyB.node == self.playerBall)) {
            
            // ジャンプ回数をリセットする
            self.playerBall.resetJumpCount()
            
            if let obstacle = contact.bodyA.node?.parent as? FallenObstacle {
                obstacle.collisionPlayerBall()
                return
            }
            
            if let obstacle = contact.bodyB.node?.parent as? FallenObstacle {
                obstacle.collisionPlayerBall()
                return
            }
        }
    }
}