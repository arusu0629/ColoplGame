//
//  Stage8.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H28/01/02.
//  Copyright © 平成28年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class Stage8: BaseStage {
    
    var obstacle: Obstacle!
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        self.setPlayerBallPosition()
        self.setObstacle()
        self.setGoalAreaPosition()
        self.setHintLabel()
    }
    
    func setPlayerBallPosition() {
        // ボールのスタートポジション(左下)
        let size = self.playerBall.frame.size
        let pos = PositionHelper.getPosition(pos: .LowerLeft, sourceView: self, size: size)
        self.playerBall.position = pos
        self.addChild(self.playerBall)
    }
    
    func setObstacle() {
        // 画面端から左右に動く障害物
        let size = CGSize(width: 50, height: 50)
        let pos = PositionHelper.getPosition(pos: .CenterRight, sourceView: self, size: size)
        self.obstacle = Obstacle(rectOfSize: size)
        self.obstacle.position = pos
        self.obstacle.configure(makeGround: false)
        self.addChild(self.obstacle)
        
        // 左右に動くSKActionを追加
        let moveLeft = SKAction.moveToX(0, duration: 2)
        let moveRight = SKAction.moveToX(self.frame.size.width, duration: 2)
        let repeatAction = SKAction.repeatActionForever(SKAction.sequence([moveLeft, moveRight]))        
        self.obstacle.runAction(repeatAction)
    }
    
    func setGoalAreaPosition() {
        // 障害物の上ゴールエリアを置く
        self.goalArea.position = CGPoint(x: 0, y: 50)
        self.obstacle.addChild(self.goalArea)
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