//
//  StageButton.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/30.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit

class StageButton: UIButton {
    // 描画専用ステージかどうかのBool変数
    var canPaintStage = false
    
    private var clearImage = UIImage(named: "Good.jpg")
    private var paintImage = UIImage(named: "Paint.jpg")

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, index: Int) {
        super.init(frame: frame)
        self.tag = index
        self.configure()
        self.paintSetImage()
    }
    
    func configure() {
        self.setTitle("Stage \(self.tag)", forState: .Normal)
        self.setTitleColor(UIColor.redColor(), forState: .Normal)
        self.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 14)
        self.backgroundColor = UIColor.whiteColor()
        self.layer.cornerRadius = CGFloat(self.frame.size.width / 2.0) // 丸くする
        self.layer.borderWidth = 1.0
        
        guard let clearData = RealmHelper.getClearData(self.tag) else {
            print("No Stage \(self.tag) Clear Data")
            return
        }
        if (!clearData.isClear) {
            return
        }
        // クリアしている場合はクリア画像をボタンに載っける
        self.setImage(clearImage, forState: .Normal)
    }
    
    func paintSetImage() {
        let paintManager = GameManager.paintManager
        if (!paintManager.paintStageIndex.contains(self.tag)) {
            return
        }
        // フラグを立てる
        self.canPaintStage = true
        
        // 描画専用のステージインデックスが含まれていた場合はボタンの右隅にそのステージを示すアイコンを表示する
        let size = self.frame.size
        let x = size.width / 2
        let y = size.height
        let iconSize = CGSize(width: size.width / 3, height: size.height / 3)
        let icon = UIImageView(frame: CGRectMake(x, y, iconSize.width, iconSize.height))
        icon.image = paintImage
        icon.center = CGPoint(x: x, y: y)
        self.addSubview(icon)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}