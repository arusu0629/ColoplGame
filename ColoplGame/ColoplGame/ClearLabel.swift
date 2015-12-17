//
//  ClearLabel.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/17.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class ClearLabel: SKLabelNode {
    
    override init() {
        super.init()
    }
    
    override init(fontNamed fontName: String?) {
        super.init(fontNamed: fontName)
        configure()
    }
    
    func configure() {
        self.fontSize = 60
        self.fontColor = UIColor.redColor()
        self.zPosition = 100
        self.text = "Clear"        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}