//
//  StageClearData.swift
//  ColoplGame
//
//  Created by ToruNakandakari on H27/12/20.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class StageClearData: Object {
    dynamic var id = 0
    // ステージ名
    dynamic var name = ""
    // クリアタイム
    dynamic var clearTime: Double = 0.0
    // クリアしたかどうかのフラグ
    dynamic var isClear = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    init(id: Int = 0, name: String = "", clearTime: Double = 0.0, isClear: Bool = false) {
        super.init()
        self.id = id
        self.name = name
        self.clearTime = clearTime
        self.isClear = isClear
    }
    
    required init() {
        super.init()
    }
    
    required override init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}