//
//  Stage5.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/18.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class Stage5: BaseStage {
    
    var obstacle: Obstacle!
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        self.setPlayerBallPosition()
        self.setObstacle()
        self.setGoalAreaPosition()
    }
    
    func setPlayerBallPosition() {
        // ボールのポジション(左下)
        let size = self.playerBall.frame.size
        let startPosition = PositionHelper.getPosition(pos: .LowerLeft, sourceView: self, size: size)
        self.playerBall.position = startPosition
        self.addChild(self.playerBall)
    }
    
    func setObstacle() {
        self.obstacle = Obstacle(rectOfSize: CGSize(width: 60, height: 60))
        let pos = CGPoint(x: self.frame.size.width - (self.obstacle.frame.size.width / 2), y: self.frame.size.height / 2 - (self.obstacle.frame.size.height / 2))
        self.obstacle.position = pos
        self.obstacle.configure()
        self.addChild(self.obstacle)
        
        // 常時上下に移動させる
        let up = SKAction.moveToY(self.frame.size.height - self.goalArea.frame.size.height, duration: 3.0)
        let down = SKAction.moveToY(self.frame.size.height / 6, duration: 3.0)
        let repeatAction = SKAction.repeatActionForever(SKAction.sequence([up, down]))
        self.obstacle.runAction(repeatAction)
    }
    
    func setGoalAreaPosition() {
        let pos = CGPoint(x: 0, y: self.goalArea.frame.size.height)
        self.goalArea.position = pos
        self.obstacle.addChild(self.goalArea)
    }
}
