//
//  SNSHelper.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H28/01/01.
//  Copyright © 平成28年 ToruNakandakari. All rights reserved.
//

import UIKit
import Social

class SNSHelper: NSObject {
    class func postToTwitter(currentViewController currentVC: UIViewController) {
        let composeVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        let clearCount = RealmHelper.getAllClearData().count
        let postText = "現在\(clearCount)つのステージをクリアしています #ColoplGame"
        composeVC.setInitialText(postText)
        currentVC.presentViewController(composeVC, animated: true, completion: nil)
    }
    
    class func postToFaceBook(currentViewController currentVC: UIViewController) {
        let composeVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        let clearCount = RealmHelper.getAllClearData().count
        let postText = "現在\(clearCount)つのステージをクリアしています #ColoplGame"
        composeVC.setInitialText(postText)
        currentVC.presentViewController(composeVC, animated: true, completion: nil)
    }

    class func postToLine(currentViewController currentVC: UIViewController) {
        let clearCount = RealmHelper.getAllClearData().count
        let postText = "現在\(clearCount)つのステージをクリアしています #ColoplGame"
        let encodeMessage = postText.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        let messageURL: NSURL! = NSURL(string: "line://msg/text/" + encodeMessage!)
        if (UIApplication.sharedApplication().canOpenURL(messageURL)) {
            UIApplication.sharedApplication().openURL( messageURL )
        } else {
            print("無効なURLです")
        }
    }

}