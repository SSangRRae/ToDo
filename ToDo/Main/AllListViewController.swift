//
//  AllListViewController.swift
//  ToDo
//
//  Created by SangRae Kim on 2/15/24.
//

import UIKit
import RealmSwift

class AllListViewController: BaseListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = ToDoTableData.shared.allData
    }
}
