//
//  Stage4.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/18.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class Stage4: BaseStage {
    
    var obstacle1: Obstacle!
    var obstacle2: Obstacle!
    var obstacle3: Obstacle!
    
    let obstacleWideSpace: CGFloat = 30
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        self.setObstacle()
        self.setPlayerBallPosition()
        self.setGoalAreaPosition()
    }
    
    // 障害物をセットする
    func setObstacle() {
        // 1つ目
        self.obstacle1 = Obstacle(rectOfSize: CGSize(width: 80, height: 500))
        let pos1 = CGPoint(x: obstacle1.frame.size.width / 2, y: 0)
        self.obstacle1.position = pos1
        self.addChild(self.obstacle1)
        self.obstacle1.configure()
        
        // 2つ目
        self.obstacle2 = Obstacle(rectOfSize: CGSize(width: 70, height: 400))
        let pos2 = CGPoint(x: self.obstacle2.frame.size.width / 2 + self.obstacle1.frame.size.width + self.obstacleWideSpace, y: 0)
        self.obstacle2.position = pos2
        self.obstacle2.configure()
        self.addChild(self.obstacle2)

        // 3つ目
        self.obstacle3 = Obstacle(rectOfSize: CGSize(width: 55, height: 600))
        let pos3 = CGPoint(x: self.obstacle3.frame.size.width / 2 + self.obstacle1.frame.size.width + self.obstacle2.frame.size.width + self.obstacleWideSpace * 2, y: 0)
        self.obstacle3.position = pos3
        self.obstacle3.configure()
        self.addChild(self.obstacle3)
    }
    
    func setPlayerBallPosition() {
        let size = self.playerBall.frame.size
        let startPosition = CGPoint(x: size.width / 2, y: self.obstacle1.frame.size.height / 2)
        self.playerBall.position = startPosition
        self.addChild(self.playerBall)
    }
    
    func setGoalAreaPosition() {
        // ゴールエリアのポジション(右下)
        let size = self.goalArea.frame.size
        let pos = CGPoint(x: self.frame.size.width - (size.width / 2), y: size.height / 2)
        self.goalArea.position = pos
        self.addChild(self.goalArea)
    }
    

}
