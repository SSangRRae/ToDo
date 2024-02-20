//
//  BaseViewController.swift
//  ToDo
//
//  Created by SangRae Kim on 2/14/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    let todoTableRepository = ToDoTableRepository()
    let listsRepository = ListsRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureView()
        configureConstraints()
    }
    
    func configureHierarchy() {}
    
    func configureView() {
        view.backgroundColor = .black
    }
    
    func configureConstraints() {}
}
