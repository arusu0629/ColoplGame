//
//  PositionHelper.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/19.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class PositionHelper: NSObject {
    enum Pos {
        // 上部
        case UpperLeft, Upper, UpperRight
        // 中部
        case CenterLeft, Center, CenterRight
        // 下部
        case LowerLeft, Lower, LowerRight
    }
    
    class func getPosition(pos pos: Pos, sourceView: SKNode, size: CGSize) -> CGPoint {
        var position = CGPointZero
        let viewSize = sourceView.frame.size
        var x: CGFloat = 0
        var y: CGFloat = 0        
        switch (pos) {
            case .UpperLeft:
                x = (size.width / 2)
                y = viewSize.height - (size.height / 2)
                position = CGPoint(x: x, y: y)
            case .Upper:
                x = viewSize.width / 2
                y = viewSize.height - (size.height / 2)
                position = CGPoint(x: x, y: y)
            case .UpperRight:
                x = viewSize.width - (size.width / 2)
                y = viewSize.height - (size.height / 2)
                position = CGPoint(x: x, y: y)
            case .CenterLeft:
                x = (size.width / 2)
                y = viewSize.height / 2
                position = CGPoint(x: x, y: y)
            case .Center:
                x = viewSize.width / 2
                y = viewSize.height / 2
                position = CGPoint(x: x, y: y)
            case .CenterRight:
                x = viewSize.width - (size.width / 2)
                y = viewSize.height / 2
                position = CGPoint(x: x, y: y)
            case .LowerLeft:
                x = (size.width / 2)
                y = (size.height / 2)
                position = CGPoint(x: x, y: y)
            case .Lower:
                x = viewSize.width / 2
                y = (size.height / 2)
                position = CGPoint(x: x, y: y)
            case . LowerRight:
                x = viewSize.width - (size.width / 2)
                y = (size.height / 2)
                position = CGPoint(x: x, y: y)
        }
        return position
    }
}