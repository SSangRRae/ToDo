//
//  TodayViewController.swift
//  ToDo
//
//  Created by SangRae Kim on 2/19/24.
//

import UIKit
import RealmSwift

class TodayViewController: BaseListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = ToDoTableData.shared.todayData
    }
}
