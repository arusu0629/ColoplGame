//
//  Stage3.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/18.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class Stage3: BaseStage {
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        self.setPlayerBallPosition()
        self.setGoalAreaPosition()
    }
    
    func setPlayerBallPosition() {
        // ボールのスタートポジション(中央下)
        let size = self.playerBall.frame.size
        let startPosition = CGPoint(x: self.frame.size.width / 2 - (size.width / 2), y: size.height / 2)
        self.playerBall.position = startPosition
        self.addChild(self.playerBall)
    }
    
    func setGoalAreaPosition() {
        // ゴールエリアのポジション
        let size = self.goalArea.frame.size
        let pos = CGPoint(x: self.frame.size.width / 2, y: size.height * 3)
        self.goalArea.position = pos
        self.addChild(self.goalArea)
    }
}
