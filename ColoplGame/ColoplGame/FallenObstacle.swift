//
//  FallenObstacle.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H28/01/03.
//  Copyright © 平成28年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

// プレイヤーボールと接触すると落下する障害物
class FallenObstacle: Obstacle {
    override func configure(makeGround makeGround: Bool) {
        super.configure(makeGround: makeGround)
        
        self.name = "Fallen Obstacle"
        self.ground.name = "Fallen Ground"
        self.fillColor = UIColor.purpleColor()
    }
    
    func collisionPlayerBall() {
        print(__FUNCTION__)
        // 0.5秒後に落下するようにする
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "fall", userInfo: nil, repeats: false)
    }
    
    func fall() {
        // 重力の影響を受けるようにする
        self.physicsBody?.affectedByGravity = true
        self.ground.physicsBody?.dynamic = true
    }
}
