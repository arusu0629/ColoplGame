//
//  PaintManager.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/29.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit

class PaintManager: NSObject {
    var lastPoint: CGPoint!
    var newPoint: CGPoint!
    var lines: [Line] = []
    var path: CGMutablePath!
    var lineObjects: [LineObject] = []
    var limitLineObjectNum = 3 // 描画できる数
    
    var paintStageIndex = [7, 8] // 描画専用ステージのインデックス
    
    func getPath() -> CGMutablePath {
        // 初期化
        self.path = CGPathCreateMutable()
        for (index, line) in self.lines.enumerate() {
            if (index == 0) {
                // 最初の始点
                CGPathMoveToPoint(self.path, nil, line.start.x, line.start.y)
            }
            // 終点
            if (index == self.lines.count - 1) {
                CGPathCloseSubpath(self.path)
                continue
            }
            // タッチした座標を元に図形を描画
            CGPathAddLineToPoint(self.path, nil, line.start.x, line.start.y)
            CGPathAddLineToPoint(self.path, nil, line.end.x, line.end.y)
        }

        // 線の配列をリセットする
        self.lines.removeAll()
        
        return self.path
    }
}