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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        print(#function)
        list = ToDoTableData.shared.allData
        tableView.reloadData()
    }
}
