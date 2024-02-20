//
//  ListsRepository.swift
//  ToDo
//
//  Created by SangRae Kim on 2/21/24.
//

import UIKit
import RealmSwift

class ListsRepository {
    let realm = try! Realm()
    
    func add(object: Object) {
        try! realm.write({
            realm.add(object)
        })
    }
    
    func readAll() -> Results<Lists> {
        return realm.objects(Lists.self)
    }
}
