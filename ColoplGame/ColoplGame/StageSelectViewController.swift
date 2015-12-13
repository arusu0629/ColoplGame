//
//  StageSelectViewController.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/13.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit

class StageSelectViewController: UIViewController {
    
    let buttonWidthMargin = 20.0 // ボタンの横間隔
    let buttonHeightMargin = 50.0 // ボタンの縦間隔
    let buttonNumPerColumn = 4.0 // 1行に並べるボタンの数
    var buttonColumnNum = 0.0 // ボタンの数による行数
    let screenWidth = Double(UIScreen.mainScreen().bounds.size.width)
    
    let buttonNum = 50.0 // 今はテストとして50個のステージボタンを配置する
    
    var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.buttonColumnNum = ceil(Double(self.buttonNum / self.buttonNumPerColumn))
        
        // スクロールビュー
        self.scrollView = UIScrollView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        self.view.addSubview(self.scrollView)
        
        // ステージボタンを表示する
        self.showStageButton()
    }
    
    func showStageButton() {
        // ボタンのサイズを決定
        let buttonSize = (self.screenWidth - self.buttonWidthMargin * (self.buttonNumPerColumn + 1)) / self.buttonNumPerColumn
        // ボタンの作成
        for (var i = 0.0; i < self.buttonNum; i++) {
            let buttonX = self.buttonWidthMargin + (buttonSize + self.buttonWidthMargin) * (i % self.buttonNumPerColumn)
            let buttonY = self.buttonHeightMargin + (buttonSize + self.buttonHeightMargin) * floor(i / self.buttonNumPerColumn)
            let buttonRect = CGRect(x: buttonX, y: buttonY, width: buttonSize, height: buttonSize)
            
            let stageButton = UIButton(frame: buttonRect)
            stageButton.setTitle("Stage\(i + 1)", forState: .Normal)
            stageButton.setTitleColor(UIColor.redColor(), forState: .Normal)
            stageButton.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 10)
            stageButton.backgroundColor = UIColor.whiteColor()
            stageButton.layer.cornerRadius = CGFloat(buttonSize / 2.0) // 丸くする
            stageButton.layer.borderWidth = 1.0
            stageButton.addTarget(self, action: "showStage:", forControlEvents: .TouchUpInside)
            self.scrollView.addSubview(stageButton)
        }
        // 増えたボタンの分だけスクロールできるようにする
        self.scrollView.contentSize = CGSize(width: 0, height: self.buttonHeightMargin + (self.buttonColumnNum + 1) * (buttonSize + self.buttonHeightMargin))
    }
    
    func showStage(sender: UIButton) {
        print("tapped Button = \(sender.titleLabel?.text)")
        // ゲームステージに遷移する
        if let gameStageVC = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("GameViewController") as? GameViewController {
            self.presentViewController(gameStageVC, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}