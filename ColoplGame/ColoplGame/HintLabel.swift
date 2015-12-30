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
    
    var texts: [String] = []
    
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
    
    init(text: String) {
        super.init(fontNamed: "Helvetica Bold")
        self.text = text
        self.configure()
    }
    
    // 複数のテキストを表示させたい場合のinitメソッド
    init(texts: String...) {
        super.init(fontNamed: "Helvetica Bold")
        for text in texts {
            self.texts.append(text)
        }
        self.text = self.texts.removeFirst()
        self.configure()
    }
    
    func configure() {
        self.fontColor = UIColor.redColor()
        self.fontSize = 12
        self.zPosition = 100
        self.alpha = 1.0
        self.horizontalAlignmentMode = .Left
    }
    
    func startAction() {
        self.runAction(SKAction.sequence([waitAction, fadeOut]), completion: nextAction)
    }
    
    func nextAction() {
        if (self.texts.count <= 0) {
            return
        }
        // まだ表示させたいテキストがある場合
        self.text = self.texts.first
        self.alpha = 1.0
        self.runAction(SKAction.sequence([waitAction, fadeOut]), completion: nextAction)
        self.texts.removeFirst()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}