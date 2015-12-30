//
//  Stage7.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/30.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

/* 描画モード専用の初ステージ */
class Stage7: BaseStage {
    
    var obstacle: Obstacle!
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        self.setPlayerBallPosition()
        self.setGoalAreaPosition()
        self.setObstacle()
        self.setHintLabel()
    }
    
    func setPlayerBallPosition() {
        // ボールのスタートポジション(右下)
        let size = self.playerBall.frame.size
        let pos = PositionHelper.getPosition(pos: .LowerRight, sourceView: self, size: size)
        self.playerBall.position = pos
        self.addChild(self.playerBall)
    }
    
    func setGoalAreaPosition() {
        // ゴールポジション(左下)
        let size = self.goalArea.frame.size
        let pos = PositionHelper.getPosition(pos: .LowerLeft, sourceView: self, size: size)
        self.goalArea.position = pos
        self.addChild(self.goalArea)
    }
    
    func setObstacle() {
        // 画面中央にダブルジャンプでは超えられない障害物を配置
        let size = CGSize(width: 20, height: 250)
        let pos = PositionHelper.getPosition(pos: .Lower, sourceView: self, size: size)
        self.obstacle = Obstacle(rectOfSize: size)
        self.obstacle.position = pos
        self.obstacle.configure()
        self.addChild(self.obstacle)
    }
    
    func setHintLabel() {
        let text1 = "上のアイコンをタップすると描画モードに切り替わるぞ!"
        let text2 = "1度に3つまで描画できるぞ!"
        let text3 = "描画されたオブジェクト上では1度ジャンプできるぞ!"
        let label = HintLabel(texts: text1, text2, text3)
        let size = label.frame.size
        let pos = CGPoint(x: (self.frame.size.width / 2) - (size.width / 2), y: self.frame.size.height - (size.height * 2))
        label.position = pos
        self.addChild(label)
        label.startAction()
    }
}
