//
//  ToDoTableData.swift
//  ToDo
//
//  Created by SangRae Kim on 2/19/24.
//

import UIKit
import RealmSwift

class ToDoTableData {
    static let shared = ToDoTableData()
    private init() {}
    
    var todayData: Results<ToDoTable>!
    var allData: Results<ToDoTable>!
    var expectedData: Results<ToDoTable>!
    var completeData: Results<ToDoTable>!
}
