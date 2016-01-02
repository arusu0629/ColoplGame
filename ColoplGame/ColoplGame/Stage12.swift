//
//  Stage12.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H28/01/03.
//  Copyright © 平成28年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class Stage12: BaseStage {
    
    var obstacle1: Obstacle!
    var obstacle2: Obstacle!
    var obstacle3: Obstacle!

    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        self.setPlayerBallPosition()
        self.setGoalAreaPosition()
        self.setObstacle()
    }
    
    func setPlayerBallPosition() {
        // ボールのスタートポジション(中央下)
        let size = self.playerBall.frame.size
        let pos = PositionHelper.getPosition(pos: .Lower, sourceView: self, size: size)
        self.playerBall.position = pos
        self.addChild(self.playerBall)
    }
    
    func setGoalAreaPosition() {
        // ゴールのポジション(右上)
        let size = self.goalArea.frame.size
        let pos = PositionHelper.getPosition(pos: .UpperRight, sourceView: self, size: size)
        self.goalArea.position = pos
        self.addChild(self.goalArea)
    }
    
    func setObstacle() {
        var widthMargin: CGFloat = 40.0
        var size = CGSize(width: self.frame.size.width - (widthMargin * 2.0), height: 20)
        var center = PositionHelper.getPosition(pos: .Center, sourceView: self, size: size)
        var pos = CGPoint(x: center.x, y: center.y - size.height * 8)
        self.obstacle1 = Obstacle(rectOfSize: size)
        self.obstacle1.position = pos
        self.obstacle1.configure(makeGround: true)
        self.addChild(self.obstacle1)
        
        // だんだんwidthが小さくなっていく
        widthMargin *= 1.5
        size = CGSize(width: self.frame.size.width - (widthMargin * 2.0), height: 20)
        pos = PositionHelper.getPosition(pos: .Center, sourceView: self, size: size)
        self.obstacle2 = Obstacle(rectOfSize: size)
        self.obstacle2.position = pos
        self.obstacle2.configure(makeGround: true)
        self.addChild(self.obstacle2)
        
        widthMargin *= 1.5
        size = CGSize(width: self.frame.size.width - (widthMargin * 2.0), height: 20)
        center = PositionHelper.getPosition(pos: .Center, sourceView: self, size: size)
        pos = CGPoint(x: center.x, y: center.y + size.height * 8)
        self.obstacle3 = Obstacle(rectOfSize: size)
        self.obstacle3.position = pos
        self.obstacle3.configure(makeGround: true)
        self.addChild(self.obstacle3)
        
        // 回転するSKActionを追加する
        print(M_PI_4)
        let rotateRight = SKAction.rotateToAngle(CGFloat(M_PI_4), duration: 2.0)
        let rotateLeft = SKAction.rotateToAngle(-CGFloat(M_PI_4), duration: 2.0)
        let repeatAction1 = SKAction.repeatActionForever(SKAction.sequence([rotateRight, rotateLeft]))
        let repeatAction2 = SKAction.repeatActionForever(SKAction.sequence([rotateLeft, rotateRight]))
        self.obstacle1.runAction(repeatAction1)
        self.obstacle2.runAction(repeatAction2)
        self.obstacle3.runAction(repeatAction1)
    }


}
