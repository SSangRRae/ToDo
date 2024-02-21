//
//  ListViewController.swift
//  ToDo
//
//  Created by SangRae Kim on 2/20/24.
//

import UIKit

class ListViewController: BaseViewController {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
        
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CheckTableViewCell.self, forCellReuseIdentifier: CheckTableViewCell.identifier)
    }
    
    override func configureView() {
        super.configureView()
        
        navigationItem.title = "새로운 목록"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(rightBarButtonClicked))
    }
    
    @objc func leftBarButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func rightBarButtonClicked() {
        guard let name else {
            view.makeToast("목록 이름을 입력해주세요", duration: 1)
            return
        }
        listsRepository.add(object: Lists(name: name))
        dismiss(animated: true)
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CheckTableViewCell.identifier, for: indexPath) as! CheckTableViewCell
        cell.nameClosure = { name in
            self.name = name
        }
        return cell
    }
}
