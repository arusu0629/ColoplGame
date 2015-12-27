//
//  Line.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/27.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit

class Line: NSObject {
    var start: CGPoint
    var end: CGPoint
    
    init(start _start: CGPoint, end _end: CGPoint) {
        self.start = _start
        self.end = _end
    }
}