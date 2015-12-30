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
        self.setHintLabel()
    }
    
    func setPlayerBallPosition() {
        // ボールのスタートポジション(左下)
        let size = self.playerBall.frame.size
        let startPosition = PositionHelper.getPosition(pos: .LowerLeft, sourceView: self, size: size)
        self.playerBall.position = startPosition
        self.addChild(self.playerBall)
    }
    
    func setGoalAreaPosition() {
        // ゴールエリアのポジション(右下)
        let size = self.goalArea.frame.size
        let pos = PositionHelper.getPosition(pos: .LowerRight, sourceView: self, size: size)
        self.goalArea.position = pos
        self.addChild(self.goalArea)
    }
    
    func setHintLabel() {
        let text = "スマートフォンを左右に傾けるとボールが転がるぞ！"
        let label = HintLabel(text: text, fontName: "Helvetica Bold")
        let size = label.frame.size
        let pos = CGPoint(x: (self.frame.size.width / 2) - (size.width / 2), y: self.frame.size.height - (size.height * 2))
        label.position = pos
        self.addChild(label)
        label.startAction()
    }
}