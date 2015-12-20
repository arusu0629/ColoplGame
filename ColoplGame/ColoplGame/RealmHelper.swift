//
//  RealmHelper.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/20.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import RealmSwift

class RealmHelper: NSObject {
    class func add(data: StageClearData) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(data, update: true)
        }
    }
    
    class func update(data: StageClearData) {
                let queue = dispatch_queue_create("background.queue", DISPATCH_QUEUE_SERIAL);
               dispatch_async(queue) {
                    autoreleasepool {
        let realm = try! Realm()
        try! realm.write {
            realm.create(StageClearData.self, value: ["id": data.id, "time": data.clearTime, "isClear": data.isClear], update: true)
        }
                }}
    }
    
    class func getClearData(id: Int) -> StageClearData? {
        let realm = try! Realm()
        if let data = realm.objects(StageClearData).filter("id = %@", id).last {
            return data
        }
        return nil
    }
    
    class func getAllClearData() -> [StageClearData] {
        let realm = try! Realm()
        let allData = realm.objects(StageClearData)
        return Array(allData)
    }
}
