//
//  SceneManager.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/15.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class SceneManager: NSObject {
    
    // 現在選択されているインデックス
    private static var stageIndex = 1
    
    private static let transitionSE = SKAction.playSoundFileNamed("transition.mp3", waitForCompletion: false)

    // スタートシーン
    class func startScene(size: CGSize) -> StartScene {
        let scene = StartScene(size: size)
        return scene
    }
    
    // ステージシーン
    class func stageScene(size: CGSize) -> BaseStage {
        // ステージインデックスからステージシーンを選択するようにする
        var scene: BaseStage = Stage1(size: size, id: stageIndex)
        switch (stageIndex) {
            case 1: scene = Stage1(size: size, id: stageIndex)
            case 2: scene = Stage2(size: size, id: stageIndex)
            case 3: scene = Stage3(size: size, id: stageIndex)
            case 4: scene = Stage4(size: size, id: stageIndex)
            case 5: scene = Stage5(size: size, id: stageIndex)
            case 6: scene = Stage6(size: size, id: stageIndex)
            default: break
        }
        return scene
    }
    
    // ステージ選択シーン
    class func stageSelectScene(size: CGSize) -> StageSelectScene {
        let scene = StageSelectScene(size: size)
        return scene
    }
    
    //シーン切り替え
    class func changeScene(view: SKView, New newScene: SKScene, Duration sec: NSTimeInterval) {
        let transition = SKTransition.fadeWithDuration(sec)
        view.presentScene(newScene, transition: transition)
        newScene.runAction(transitionSE)
    }
    
    class func setStageIndex(index: Int) {
        stageIndex = index
    }
}
