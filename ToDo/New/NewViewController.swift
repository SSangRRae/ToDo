//
//  NewViewController.swift
//  ToDo
//
//  Created by SangRae Kim on 2/14/24.
//

import UIKit

class NewViewController: BaseViewController {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    var subTitles: [String?] = [nil, nil, nil, nil, nil]

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
        return indexPath.section == 0 ? 150 : 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = MemoTableViewCell()
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
                self.subTitles[indexPath.section] = date
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
        let rightBarButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(rightBarButtonClicked))
        navigationItem.title = "새로운 할 일"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func leftBarButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func rightBarButtonClicked() {
        
    }
}
