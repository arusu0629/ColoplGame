//
//  Stage9.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H28/01/02.
//  Copyright © 平成28年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class Stage9: BaseStage {
    
    var obstacle: Obstacle!
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        self.setPlayerBallPosition()
        self.setObstacle()
        self.setGoalAreaPosition()
    }
    
    func setPlayerBallPosition() {
        // ボールのスタートポジション(右下)
        let size = self.playerBall.frame.size
        let pos = PositionHelper.getPosition(pos: .LowerRight, sourceView: self, size: size)
        self.playerBall.position = pos
        self.addChild(self.playerBall)
    }
    
    func setObstacle() {
        // 画面中央に回転する障害物を置く
        let size = CGSize(width: 50, height: 100)
        let pos = PositionHelper.getPosition(pos: .Center, sourceView: self, size: size)
        
        self.obstacle = Obstacle(rectOfSize: size)
        self.obstacle.position = pos
        self.obstacle.configure(makeGround: false)
        self.obstacle.zRotation = (-CGFloat(M_PI) / 2) // 右に90度回転させておく
        self.addChild(self.obstacle)
        
        // 回転するSKActionを追加する
        let rotationLeft = SKAction.rotateByAngle(CGFloat(M_PI), duration: 0.7)
        let rotationRight = SKAction.rotateByAngle(-CGFloat(M_PI), duration: 0.7)
        let repeatAction = SKAction.repeatActionForever(SKAction.sequence([rotationLeft, rotationRight]))
        self.obstacle.runAction(repeatAction)
    }
    
    func setGoalAreaPosition() {
        // 障害物の上ゴールエリアを置く
        self.goalArea.position = CGPoint(x: 0, y: 100 - (self.goalArea.frame.size.height / 2))
        self.obstacle.addChild(self.goalArea)
    }
}
