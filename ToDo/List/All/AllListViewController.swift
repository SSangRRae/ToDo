//
//  AllListViewController.swift
//  ToDo
//
//  Created by SangRae Kim on 2/15/24.
//

import UIKit
import RealmSwift

class AllListViewController: BaseViewController {
    
    let tableView = UITableView()
    
    var list: Results<ToDoTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        
        list = realm.objects(ToDoTable.self)
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureView() {
        super.configureView()
        configureNavigation()
        tableView.backgroundColor = .black
        tableView.rowHeight = 70
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AllListTableViewCell.self, forCellReuseIdentifier: "allCell")
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureNavigation() {
        let realm = try! Realm()
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        
        let deadline = UIAction(title: "마감일 순으로 보기") { _ in
            self.list = realm.objects(ToDoTable.self).sorted(byKeyPath: "deadline", ascending: true)
            self.tableView.reloadData()
        }
        let title = UIAction(title: "제목 순으로 보기") { _ in
            self.list = realm.objects(ToDoTable.self).sorted(byKeyPath: "title", ascending: true)
            self.tableView.reloadData()
        }
        let priority = UIAction(title: "우선순위 높음만 보기") { _ in
            self.list = realm.objects(ToDoTable.self).where {
                $0.priority == "높음"
            }
            self.tableView.reloadData()
        }
        button.menu = UIMenu(options: .displayInline, children: [deadline, title, priority])
        button.showsMenuAsPrimaryAction = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
}

extension AllListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allCell", for: indexPath) as! AllListTableViewCell
        cell.configureView(item: list[indexPath.row])
        return cell
    }
}
