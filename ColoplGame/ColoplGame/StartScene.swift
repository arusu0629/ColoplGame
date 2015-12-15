//
//  StartScene.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/15.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class StartScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        self.configureTitleLabel()
    }
        
    func configureTitleLabel() {
        let sceneSize = self.frame.size
        
        let titleLabel = SKLabelNode(fontNamed: "Helvetica Bold")
        titleLabel.fontSize = 48
        titleLabel.fontColor = UIColor.blackColor()
        titleLabel.position = CGPoint(x: sceneSize.width / 2, y: sceneSize.height / 2)
        titleLabel.zPosition = 100
        titleLabel.text = "Colopl Game"
        self.addChild(titleLabel)
        
        // ラベルの下にフェードイン/アウトを繰り返した小さなラベルを表示
        let label = SKLabelNode(fontNamed: "Helvetica")
        label.fontSize = 20
        label.fontColor = UIColor.redColor()
        label.position = CGPoint(x: titleLabel.position.x, y: titleLabel.position.y - titleLabel.frame.size.height)
        label.zPosition = 100
        label.text = "Start Game"
        
        let fadeOut = SKAction.fadeAlphaTo(0, duration: 0.7)
        let fadeIn = SKAction.fadeAlphaTo(1, duration: 0.7)
        let repeatAction = SKAction.repeatActionForever(SKAction.sequence([fadeOut, fadeIn]))
        label.runAction(repeatAction)
        
        self.addChild(label)
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }

    override init() {
        super.init()
        self.backgroundColor = UIColor.whiteColor()
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
