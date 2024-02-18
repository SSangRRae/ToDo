//
//  NewViewController.swift
//  ToDo
//
//  Created by SangRae Kim on 2/14/24.
//

import UIKit
import RealmSwift
import Toast

class NewViewController: BaseViewController {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var memoTitle: String?
    var memo: String?
    var deadline: Date = Date()
    var subTitles: [String?] = [nil, nil, nil, nil, nil]

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        NotificationCenter.default.addObserver(self, selector: #selector(recivedNotification), name: NSNotification.Name("TagRecived"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(recivedNotification), name: NSNotification.Name("PriorityRecived"), object: nil)
    }
    
    @objc func recivedNotification(notification: NSNotification) {
        if let value = notification.userInfo?["tag"] as? String {
            subTitles[2] = value
            tableView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .automatic)
        }
        if let value = notification.userInfo?["priority"] as? String {
            subTitles[3] = value
            tableView.reloadRows(at: [IndexPath(row: 0, section: 3)], with: .automatic)
        }
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureView() {
        super.configureView()
        
        configureNavigation()
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension NewViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return NewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 100 : 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = MemoTableViewCell()
            cell.titleClosure = { self.memoTitle = $0 }
            cell.memoClosure = { self.memo = $0 }
            return cell
        }
        
        let cell = InfoTableViewCell(style: .value1, reuseIdentifier: "info")
        cell.configureCell(title: NewSection.allCases[indexPath.section].rawValue, subTitle: subTitles[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = DateViewController()
            vc.carry = { date in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                self.deadline = date
                self.subTitles[indexPath.section] = dateFormatter.string(from: date)
                self.tableView.reloadRows(at: [IndexPath(row: 0, section: indexPath.section)], with: .automatic)
            }
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == 2 {
            let vc = TagViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == 3 {
            let vc = PriorityViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension NewViewController {
    func configureNavigation() {
        let leftBarButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(leftBarButtonClicked))
        let rightBarButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonClicked))
        navigationItem.title = "새로운 할 일"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func leftBarButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func addButtonClicked() {
        guard let memoTitle else {
            view.makeToast("제목을 입력해주세요", duration: 1)
            return
        }
        if subTitles[1] == nil {
            view.makeToast("마감일을 입력해주세요", duration: 1)
            return
        }
        guard let priority = subTitles[3] else {
            view.makeToast("우선 순위를 선택해주세요", duration: 1)
            return
        }
        
        let realm = try! Realm()
        let data = ToDoTable(complete: false, title: memoTitle, memo: memo, deadline: deadline, tag: subTitles[2], priority: priority)
        
        try! realm.write {
            realm.add(data)
        }
        
        dismiss(animated: true)

    }
}
