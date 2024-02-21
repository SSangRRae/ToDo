//
//  ListSelectViewController.swift
//  ToDo
//
//  Created by SangRae Kim on 2/21/24.
//

import UIKit
import RealmSwift

class ListSelectViewController: BaseViewController {
    
    let tableView = UITableView()
    var list: Results<Lists>!
    var closure: ((Lists) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureView() {
        super.configureView()
        
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        
        list = listsRepository.readAll()
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ListSelectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .black
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = list[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        closure(list[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}
