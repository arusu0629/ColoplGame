//
//  Stage1.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/17.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

// ステージ1のシーン
class Stage1: BaseStage {
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        self.setPlayerBallPosition()
        self.setGoalAreaPosition()
    }
    
    func setPlayerBallPosition() {
        // ボールのスタートポジション(左下)
        let size = self.playerBall.frame.size
        let startPosition = CGPoint(x: size.width / 2, y: size.height / 2)
        self.playerBall.position = startPosition
        self.addChild(self.playerBall)
    }
    
    func setGoalAreaPosition() {
        self.goalArea.configure()
        
        // ゴールエリアのポジション(右下)
        let size = self.goalArea.frame.size
        let pos = CGPoint(x: self.frame.size.width - (size.width / 2), y: size.height / 2)
        self.goalArea.position = pos
        self.addChild(self.goalArea)
    }
}