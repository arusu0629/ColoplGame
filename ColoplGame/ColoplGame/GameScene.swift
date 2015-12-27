//
//  GameScene.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/17.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit

class GameScene: NSObject {
    struct ColliderType {
        static let PlayerBall: UInt32 = (1 << 0)
        static let GoalArea: UInt32 = (1 << 1)
        static let World: UInt32 = (1 << 2)
        static let Other: UInt32 = (1 << 3)
        static let Obstacle: UInt32 = (1 << 4)
        static let LineObject: UInt32 = (1 << 5)
        static let Ground: UInt32 = (1 << 6)
        static let None: UInt32 = (1 << 7)
    }
}
