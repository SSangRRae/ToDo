//
//  BaseListViewController.swift
//  ToDo
//
//  Created by SangRae Kim on 2/19/24.
//

import UIKit
import RealmSwift

class BaseListViewController: BaseViewController {
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    var list: Results<ToDoTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureView() {
        super.configureView()
        configureNavigation()
        tableView.backgroundColor = .black
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.identifier)
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureNavigation() {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        
        let deadline = UIAction(title: "마감일 순으로 보기") { _ in
            self.list = self.repository.readAllWithSort(byKeyPath: "deadline")
            self.tableView.reloadData()
        }
        let title = UIAction(title: "제목 순으로 보기") { _ in
            self.list = self.repository.readAllWithSort(byKeyPath: "title")
            self.tableView.reloadData()
        }
        let priority = UIAction(title: "우선순위 높음만 보기") { _ in
            self.list = ToDoTableData.shared.allData.where {
                $0.priority == "높음"
            }
            self.tableView.reloadData()
        }
        button.menu = UIMenu(options: .displayInline, children: [deadline, title, priority])
        button.showsMenuAsPrimaryAction = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
}

extension BaseListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath) as! ToDoTableViewCell
        cell.configureView(item: list[indexPath.row])
        cell.completeButton.tag = indexPath.row
        cell.completeButton.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewViewController()
        vc.todo = list[indexPath.row]
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "삭제") { action, view, completionHandler in
            self.repository.delete(column: self.list[indexPath.row])
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions:[delete])
    }
}

extension BaseListViewController {
    @objc func completeButtonClicked(_ sender: UIButton) {
        let tag = sender.tag
        repository.update(value: ["id": list[tag].id, "complete": !list[tag].complete])
        tableView.reloadData()
    }
}
