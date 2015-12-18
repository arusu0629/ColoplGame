//
//  HintLabel.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/18.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class HintLabel: SKLabelNode {
    
    let fadeOut = SKAction.fadeAlphaTo(0, duration: 1.0)
    let waitAction = SKAction.waitForDuration(3.0)
    
    override init() {
        super.init()
        self.configure()
    }
    
    override init(fontNamed fontName: String?) {
        super.init(fontNamed: fontName)
        self.configure()
    }
   
    init(text: String, fontName: String?) {
        super.init(fontNamed: fontName)
        self.text = text
        self.configure()
    }
    
    func configure() {
        self.fontColor = UIColor.redColor()
        self.fontSize = 12
        self.zPosition = 100
        self.alpha = 1.0
        self.horizontalAlignmentMode = .Left
        self.runAction(SKAction.sequence([waitAction, fadeOut]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}