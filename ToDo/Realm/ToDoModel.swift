//
//  ToDoModel.swift
//  ToDo
//
//  Created by SangRae Kim on 2/15/24.
//

import UIKit
import RealmSwift

class Lists: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var regDate: Date
    
    @Persisted var todo: List<ToDoTable>
    
    convenience init(name: String, regDate: Date = Date()) {
        self.init()
        self.name = name
        self.regDate = regDate
    }
}

class ToDoTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var complete: Bool
    @Persisted var title: String
    @Persisted var memo: String?
    @Persisted var deadline: Date
    @Persisted var tag: String?
    @Persisted var priority: String
    
    @Persisted(originProperty: "todo") var list: LinkingObjects<Lists>
    
    convenience init(complete: Bool = false, title: String, memo: String? = nil, deadline: Date, tag: String? = nil, priority: String) {
        self.init()
        self.title = title
        self.memo = memo
        self.deadline = deadline
        self.tag = tag
        self.priority = priority
    }
}

class Tag: EmbeddedObject {
    @Persisted var name: String
}
