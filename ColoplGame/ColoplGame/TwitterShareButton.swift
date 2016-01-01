//
//  TwitterShareButton.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H28/01/01.
//  Copyright © 平成28年 ToruNakandakari. All rights reserved.
//

import UIKit

class TwitterShareButton: UIButton {

    var currentViewController: UIViewController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, currentViewController: UIViewController) {
        super.init(frame: frame)
        self.configure()
        self.currentViewController = currentViewController
    }
    
    func configure() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.setImage(UIImage(named: "Twitter.jpg"), forState: .Normal)
        self.addTarget(self, action: "postTwitter", forControlEvents: .TouchUpInside)
    }
    
    func postTwitter() {
        SNSHelper.postToTwitter(currentViewController: self.currentViewController)
    }
}