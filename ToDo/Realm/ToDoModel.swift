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
    @Persisted var complete: Bool
    @Persisted var title: String
    @Persisted var memo: String?
    @Persisted var deadline: Date
    @Persisted var tag: String?
    @Persisted var priority: String
    
    convenience init(complete: Bool, title: String, memo: String? = nil, deadline: Date, tag: String? = nil, priority: String) {
        self.init()
        self.complete = complete
        self.title = title
        self.memo = memo
        self.deadline = deadline
        self.tag = tag
        self.priority = priority
    }
}
