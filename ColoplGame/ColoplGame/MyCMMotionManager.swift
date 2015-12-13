//
//  MyCMMotionManager.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/13.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import CoreMotion

class MyCMMotionManager: CMMotionManager {
    let updateInterval: NSTimeInterval = 0.1 // 加速度の取得間隔
    var accelerometerHandler: CMAccelerometerHandler! // 加速度を取得した際のイベントハンドラ
    var accelerationX: Double = 0.0
    var accelerationY: Double = 0.0
    
    override init() {
        super.init()
        self.setup()
    }
    
    func setup() {
        self.accelerometerUpdateInterval = updateInterval
        // ハンドラの設定
        self.accelerometerHandler = {
            (data: CMAccelerometerData?, error: NSError?) -> Void in
            
            // ログにx,y,zの加速度を表示
            print("x:\(data?.acceleration.x) y:\(data?.acceleration.x) z:\(data?.acceleration.z)")
            // 現在の加速度センサーの値を保存しておく
            if let x = data?.acceleration.x {
                self.accelerationX = x
            }
            if let y = data?.acceleration.y {
                self.accelerationY = y
            }
        }
    }
    
    func startAccelerometerUpdate() {
        self.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: self.accelerometerHandler)
    }
}
