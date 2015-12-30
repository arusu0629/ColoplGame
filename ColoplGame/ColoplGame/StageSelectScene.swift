//
//  StageSelectScene.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/15.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SpriteKit

class StageSelectScene: SKScene {
    
    var changeSceneDelegate: ChangeSceneProtocol!
    
    let buttonWidthMargin = 20.0 // ボタンの横間隔
    let buttonHeightMargin = 50.0 // ボタンの縦間隔
    let buttonNumPerColumn = 3.0 // 1行に並べるボタンの数
    var buttonColumnNum = 0.0 // ボタンの数による行数
    let screenWidth = Double(UIScreen.mainScreen().bounds.size.width)
    
    let nextStageShowNum = 3.0 // 何個先のステージまで表示するかの数
    var buttonNum = 0.0
    
    var scrollView: UIScrollView!
    
    override func didMoveToView(view: SKView) {
        self.buttonNum = Double(RealmHelper.getAllClearData().count) + self.nextStageShowNum
        self.buttonColumnNum = ceil(Double(self.buttonNum / self.buttonNumPerColumn))
        
        // スクロールビュー
        self.scrollView = UIScrollView(frame: CGRectMake(0, 0, self.view!.frame.size.width, self.view!.frame.size.height))
        self.view!.addSubview(self.scrollView)
        
        // ステージボタンを表示する
        // ボタンがいきなり表示されておかしいため、遅延実行して表示するようにする
        NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: "showStageButton", userInfo: nil, repeats: false)
    }
    
    func showStageButton() {
        // ナビゲーションバーを非表示にする
        let gameView = self.view
        // 現在のビューの親のViewControllerを取得
        if let gameViewController = ViewControllerHelper.getRootViewController((gameView)!) as? GameViewController {
            if (!gameViewController.navigationController!.navigationBarHidden) {
                gameViewController.navigationController?.navigationBarHidden = true
            }
        }
        // ボタンのサイズを決定
        let buttonSize = (self.screenWidth - self.buttonWidthMargin * (self.buttonNumPerColumn + 1)) / self.buttonNumPerColumn
        // ボタンの作成
        for (var i = 0.0; i < self.buttonNum; i++) {
            // ステージボタンの座標決め
            let buttonX = self.buttonWidthMargin + (buttonSize + self.buttonWidthMargin) * (i % self.buttonNumPerColumn)
            let buttonY = self.buttonHeightMargin + (buttonSize + self.buttonHeightMargin) * floor(i / self.buttonNumPerColumn)
            let buttonRect = CGRect(x: buttonX, y: buttonY, width: buttonSize, height: buttonSize)
            
            let stageButton = StageButton(frame: buttonRect, index: Int(i + 1))
            stageButton.addTarget(self, action: "showStage:", forControlEvents: .TouchUpInside)

            self.scrollView.addSubview(stageButton)
        }
        // 増えたボタンの分だけスクロールできるようにする
        self.scrollView.contentSize = CGSize(width: 0, height: self.buttonHeightMargin + (self.buttonColumnNum + 1) * (buttonSize + self.buttonHeightMargin))
    }
    
    func showStage(sender: StageButton) {
        SceneManager.setStageIndex(sender.tag)
        changeSceneDelegate.changeScene(self)
        
        guard let gameVC = ViewControllerHelper.getRootViewController(self.view!) as? GameViewController else {
            print("Cannot get gameViewController ")
            return
        }

        // 描画専用ステージの場合はナビゲーションバーの中央のボタンを非表示にしない
        if (sender.canPaintStage) {
            gameVC.navigationItem.titleView?.hidden = false
        } else {
            gameVC.navigationItem.titleView?.hidden = true
        }
        
        if (self.scrollView.hidden) {
            return
        }
        self.scrollView.hidden = true
    }

    override init() {
        super.init()
        self.backgroundColor = UIColor.whiteColor()
    }
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
