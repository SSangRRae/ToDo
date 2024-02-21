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
    
    func add(object: Object?) {
        try! realm.write({
            realm.add(object!)
        })
    }
    
    func readAll() {
        print(realm.configuration.fileURL!)
        ToDoTableData.shared.allData = realm.objects(ToDoTable.self)
        fetch()
    }
    
    func fetch() {
        let today = Calendar.current.startOfDay(for: Date())
        let end = Calendar.current.date(byAdding: .day, value: 1, to: today) ?? Date()
        var predicate = NSPredicate(format: "deadline >= %@ && deadline < %@", today as NSDate, end as NSDate)
        
        ToDoTableData.shared.todayData = ToDoTableData.shared.allData.filter(predicate)
        predicate = NSPredicate(format: "deadline >= %@", end as NSDate)
        ToDoTableData.shared.expectedData = ToDoTableData.shared.allData.filter(predicate)
        ToDoTableData.shared.completeData = ToDoTableData.shared.allData.where { $0.complete == true }
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
    
    func update(id: ObjectId, memoTitle: String, memo: String?, deadline: Date, tag: String?, priority: String) {
        try! realm.write {
            realm.create(ToDoTable.self,
                         value: ["id": id, "title": memoTitle, "memo": memo,
                                 "deadline": deadline, "tag": tag, "priority": priority],
                         update: .modified)
        }
    }
    
    func updateComplete(value: [String: Any]) {
        try! realm.write {
            realm.create(ToDoTable.self,
                         value: value,
                         update: .modified)
        }
    }
}
