//
//  ToDoModel.swift
//  ToDo
//
//  Created by SangRae Kim on 2/15/24.
//

import UIKit
import RealmSwift

class ToDoTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var memo: String?
    @Persisted var deadline: Date
    @Persisted var tag: String
    @Persisted var priority: String
    
    convenience init(title: String, memo: String? = nil, deadline: Date, tag: String, priority: String) {
        self.init()
        self.title = title
        self.memo = memo
        self.tag = tag
        self.priority = priority
    }
}
