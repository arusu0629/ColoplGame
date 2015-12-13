//
//  StartViewController.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/13.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // タッチした時にステージ選択画面に遷移する
        let stageVC = StageSelectViewController()
        self.presentViewController(stageVC, animated: true, completion: nil)
    }
}