//
//  UIViewControllerHelper.swift
//  PackMen
//
//  Created by Keito GIBO on 2015/01/06.
//  Copyright (c) 2015年 ToruNakandakari. All rights reserved.
//

import UIKit

// 引数で受け取ったviewの親のViewControllerを返すヘルパークラス
class ViewControllerHelper: NSObject {
    class func getRootViewController(view: UIView) -> UIViewController? {
        for (var next: UIView? = view; next != nil; next = next?.superview) {
            let nextResponder = next?.nextResponder()
            if let myViewController = nextResponder as? UIViewController {
                return myViewController
            }
        }
        return nil
    }
}
