//
//  CompleteViewController.swift
//  ToDo
//
//  Created by SangRae Kim on 2/19/24.
//

import UIKit
import RealmSwift

class CompleteViewController: BaseListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = ToDoTableData.shared.completeData
    }
}
