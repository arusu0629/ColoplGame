//
//  FadeInOutLabel.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/17.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class FadeInOutLabel: SKLabelNode {
    
    let fadeOut = SKAction.fadeAlphaTo(0, duration: 0.7)
    let fadeIn = SKAction.fadeAlphaTo(1, duration: 0.7)
    var repeatAction: SKAction!
    
    override init() {
        super.init()
    }
    
    init(text: String, fontName: String?) {
        super.init(fontNamed: fontName)
        self.text = text
        self.alpha = 0
        self.repeatAction = SKAction.repeatActionForever(SKAction.sequence([fadeIn, fadeOut]))
        self.runAction(self.repeatAction)
        configure()
    }
    
    func configure() {
        self.fontSize = 20
        self.fontColor = UIColor.blackColor()
        self.zPosition = 100
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}