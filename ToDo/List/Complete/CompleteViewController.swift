//
//  CompleteViewController.swift
//  ToDo
//
//  Created by SangRae Kim on 2/19/24.
//

import UIKit
import RealmSwift

class CompleteViewController: BaseViewController {
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    let repository = ToDoTableRepository()
    var list: Results<ToDoTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = repository.readAll().where { $0.complete == true }
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureView() {
        super.configureView()
        tableView.backgroundColor = .black
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "allCell")
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension CompleteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allCell", for: indexPath) as! ListTableViewCell
        cell.configureView(item: list[indexPath.row])
        cell.completeButton.tag = indexPath.row
        cell.completeButton.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
        return cell
    }
}

extension CompleteViewController {
    @objc func completeButtonClicked(_ sender: UIButton) {
        let tag = sender.tag
        repository.update(value: ["id": list[tag].id, "complete": !list[tag].complete])
        tableView.reloadData()
    }
}
