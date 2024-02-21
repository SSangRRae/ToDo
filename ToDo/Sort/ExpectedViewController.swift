//
//  ExpectedViewController.swift
//  ToDo
//
//  Created by SangRae Kim on 2/19/24.
//

import UIKit

class ExpectedViewController: BaseListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = ToDoTableData.shared.expectedData
    }
}
