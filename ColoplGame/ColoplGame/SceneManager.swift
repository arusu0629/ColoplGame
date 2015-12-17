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
    static var stageIndex = 0

    // スタートシーン
    class func startScene(size: CGSize) -> StartScene {
        let scene = StartScene(size: size)
        return scene
    }
    
    // ステージシーン
    class func stageScene(size: CGSize) -> BaseStage {
        // ステージインデックスからステージシーンを選択するようにする(未実装)
        let scene = Stage1(size: size)
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
    }
}
