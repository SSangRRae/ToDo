//
//  ToDoTableRepository.swift
//  ToDo
//
//  Created by SangRae Kim on 2/19/24.
//

import UIKit
import RealmSwift

class ToDoTableRepository {
    let realm = try! Realm()
    
    func readAll() -> Results<ToDoTable> {
        return realm.objects(ToDoTable.self)
    }
    
    func readAllWithSort(byKeyPath: String) -> Results<ToDoTable> {
        return realm.objects(ToDoTable.self).sorted(byKeyPath: byKeyPath, ascending: true)
    }
    
    func read(forPrimaryKey: ObjectId) -> ToDoTable {
        return realm.object(ofType: ToDoTable.self, forPrimaryKey: forPrimaryKey)!
    }
    
    func delete(column: ToDoTable) {
        try! realm.write { realm.delete(column) }
    }
    
    func update(value: [String: Any]) {
        try! realm.write {
            realm.create(ToDoTable.self, value: value, update: .modified)
        }
    }
}
