//
//  ListViewController.swift
//  ToDo
//
//  Created by SangRae Kim on 2/14/24.
//

import UIKit

class ListViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        
    }
    
    override func configureView() {
        super.configureView()
        configureToolBar()
    }
    
    override func configureConstraints() {
        
    }
}

extension ListViewController {
    func configureToolBar() {
        let button = UIButton()
        button.setTitle("새로운 할 일", for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(addNewToDoButtonClicked), for: .touchUpInside)
        let addNewToDoButton = UIBarButtonItem(customView: button)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let addList = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: #selector(addListButtonClicked))
        
        navigationController?.isToolbarHidden = false
        navigationController?.toolbar.tintColor = .white
        toolbarItems = [addNewToDoButton, flexibleSpace, addList]
    }
    
    @objc func addNewToDoButtonClicked() {
        let vc = UINavigationController(rootViewController: NewViewController())
        present(vc, animated: true)
    }
    
    @objc func addListButtonClicked() {
        
    }
}
