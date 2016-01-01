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
    var snsView: UIView!
    var snsViewHeight: CGFloat = 40
    var snsShareButtonWidth: CGFloat = 40
    
    override func didMoveToView(view: SKView) {
        
        // ナビゲーションバーを非表示にする
        let gameView = self.view
        // 現在のビューの親のViewControllerを取得
        if let gameViewController = ViewControllerHelper.getRootViewController((gameView)!) as? GameViewController {
            if (!gameViewController.navigationController!.navigationBarHidden) {
                gameViewController.navigationController?.navigationBarHidden = true
            }
        }
        
        // 表示するステージボタンの数を決める
        self.buttonNum = Double(RealmHelper.getAllClearData().count) + self.nextStageShowNum
        self.buttonColumnNum = ceil(Double(self.buttonNum / self.buttonNumPerColumn))
        
        // スクロールビュー
        self.scrollView = UIScrollView(frame: CGRectMake(0, 0, self.view!.frame.size.width, self.view!.frame.size.height - self.snsViewHeight))
        self.view!.addSubview(self.scrollView)
        
        if (self.scrollView.hidden) {
            self.scrollView.hidden = false
            self.snsView.hidden = false
        }
        
        // ステージボタンを表示する
        // ボタンがいきなり表示されておかしいため、遅延実行して表示するようにする
        NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: "showStageButton", userInfo: nil, repeats: false)
        
        // 画面下にSNSViewを表示する
        NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: "setSNSView", userInfo: nil, repeats: false)
    }
    
    func showStageButton() {
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
        
        // ジャンプモードなどの設定をリセットする
        gameVC.resetCenterButton()
        
        if (self.scrollView.hidden) {
            return
        }
        self.scrollView.hidden = true
        self.snsView.hidden = true
    }
    
    func setSNSView() {
        // GameViewControllerを取得する
        guard let gameVC = ViewControllerHelper.getRootViewController(self.view!) as? GameViewController else {
            print("Cannot get gameViewController ")
            return
        }
        
        let width = self.frame.size.width
        let y = self.scrollView.frame.size.height
        var rect = CGRectMake(0, y, width, self.snsViewHeight)
        self.snsView = UIView(frame: rect)
        self.view?.addSubview(self.snsView)
        
        let shareButtonWidthMargin = ((width) - (self.snsShareButtonWidth * 2)) / 3

        // Twitterシェアボタンを作成
        var point = CGPoint(x: shareButtonWidthMargin, y: 0)
        let size = CGSize(width: self.snsShareButtonWidth, height: self.snsViewHeight)
        rect = CGRectMake(point.x, point.y, size.width, size.height)
        let twitterButton = TwitterShareButton(frame: rect, currentViewController: gameVC)
        self.snsView.addSubview(twitterButton)
        
        // LINEシェアボタンを作成
        point = CGPoint(x: shareButtonWidthMargin * 2 + (self.snsShareButtonWidth), y: 0)
        rect = CGRectMake(point.x, point.y, size.width, size.height)
        let lineButton = LineShareButton(frame: rect, currentViewController: gameVC)
        self.snsView.addSubview(lineButton)
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
