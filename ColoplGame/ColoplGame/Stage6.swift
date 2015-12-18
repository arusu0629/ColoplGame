//
//  Stage6.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/18.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class Stage6: BaseStage {

    var obstacle1: Obstacle!
    var obstacle2: Obstacle!
    var obstacle3: Obstacle!
    
    let obstacleWideSpace: CGFloat = 30
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        self.setPlayerBallPosition()
        self.setGoalAreaPosition()
        self.setObstacle()
    }
    
    func setObstacle() {
        self.obstacle1 = Obstacle(rectOfSize: CGSize(width: 50, height: 200))
        let x1 = (self.goalArea.frame.size.width + self.obstacleWideSpace + self.obstacle1.frame.size.width / 2)
        let y1 = ((self.frame.size.height - self.goalArea.frame.size.height) - self.obstacle1.frame.size.height)
        let pos1 = CGPoint(x: x1, y: y1)
        self.obstacle1.position = pos1
        self.obstacle1.configure()
        self.addChild(self.obstacle1)
        
        self.obstacle2 = Obstacle(rectOfSize: CGSize(width: 50, height: 200))
        let x2 = (self.obstacle1.position.x + self.obstacleWideSpace + self.obstacle2.frame.size.width)
        let y2 = self.obstacle1.position.y
        self.obstacle2.position = CGPoint(x: x2, y: y2)
        self.obstacle2.configure()
        self.addChild(self.obstacle2)
        
        // 上下に動く障害物
        self.obstacle3 = Obstacle(rectOfSize: CGSize(width: 50, height: self.frame.size.height))
        let x3 = self.frame.size.width - (self.obstacle3.frame.size.width / 2)
        self.obstacle3.position = CGPoint(x: x3, y: 0)
        self.obstacle3.configure()
        self.addChild(self.obstacle3)
    
        let up = SKAction.moveToY((self.obstacle1.position.y + self.obstacle1.frame.size.height / 2) - (self.obstacle3.frame.size.height / 2), duration: 2)
        let down = SKAction.moveToY(-self.obstacle3.frame.size.height / 3, duration: 2)
        let repeatAction = SKAction.repeatActionForever(SKAction.sequence([up, down]))
        self.obstacle3.runAction(repeatAction)
    }
    
    func setPlayerBallPosition() {
        // 画面左下に配置
        let pos = CGPoint(x: self.playerBall.frame.size.width / 2, y: self.playerBall.frame.size.height / 2)
        self.playerBall.position = pos
        self.addChild(playerBall)
    }
    
    func setGoalAreaPosition() {
        // 画面左上に配置
        let size = self.frame.size
        let pos = CGPoint(x: self.goalArea.frame.size.width / 2, y: size.height - (self.goalArea.frame.size.height / 2))
        self.goalArea.position = pos
        self.addChild(self.goalArea)
    }
}
