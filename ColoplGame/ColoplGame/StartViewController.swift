//
//  StartViewController.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/13.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    var canTouch = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.canTouch = true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (!canTouch) {
            return
        }        
        // タッチした時にステージ選択画面に遷移する
        let stageVC = StageSelectViewController()
        self.presentViewController(stageVC, animated: true, completion: nil)
    }
}