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
    
    var todo: ToDoTable? = nil
    var memoTitle: String?
    var memo: String?
    var deadline: String?
    var tag: String?
    var priority: String?
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        NotificationCenter.default.addObserver(self, selector: #selector(receivedNotification), name: NSNotification.Name("deadline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(receivedNotification), name: NSNotification.Name("tag"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(receivedNotification), name: NSNotification.Name("priority"), object: nil)
    }
    
    @objc func receivedNotification(notification: NSNotification) {
        if let value = notification.userInfo?["deadline"] as? String {
            deadline = value
            tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
        }
        
        if let value = notification.userInfo?["tag"] as? String {
            tag = value
            tableView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .automatic)
        }
        
        if let value = notification.userInfo?["priority"] as? String {
            priority = value
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
        tableView.register(MemoTableViewCell.self, forCellReuseIdentifier: MemoTableViewCell.identifier)
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifier)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as! MemoTableViewCell
            if let todo {
                cell.titleTextField.text = todo.title
                cell.memoTextField.text = todo.memo
                return cell
            }
            cell.titleClosure = { self.memoTitle = $0 }
            cell.memoClosure = { self.memo = $0 }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as! InfoTableViewCell
            
            if let todo {
                var value: String?
                
                switch indexPath.section {
                case NewSection.deadline.rawValue: value = dateToString(date: todo.deadline)
                case NewSection.tag.rawValue: value = todo.tag
                case NewSection.priority.rawValue: value = todo.priority
                case NewSection.image.rawValue: cell.selectedImageView.image = loadImageToDocument(fileName: "\(todo.id)")
                default: break
                }
                cell.configureCell(title: NewSection.allCases[indexPath.section].title, value: value)
                return cell
            }
            var value: String?
            
            switch indexPath.section {
            case NewSection.deadline.rawValue: value = deadline
            case NewSection.tag.rawValue: value = tag
            case NewSection.priority.rawValue: value = priority
            case NewSection.image.rawValue:
                if let image {
                    cell.selectedImageView.image = image
                }
            default: break
            }
            cell.configureCell(title: NewSection.allCases[indexPath.section].title, value: value)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = DateViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == 2 {
            let vc = TagViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == 3 {
            let vc = PriorityViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = UIImagePickerController()
            vc.allowsEditing = true
            vc.delegate = self
            present(vc, animated: true)
        }
    }
}

extension NewViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage { image = pickedImage }
        tableView.reloadData()
        dismiss(animated: true)
    }
}

extension NewViewController {
    func configureNavigation() {
        if let todo {
            let leftBarButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(leftBarButtonClicked))
            let rightBarButton = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(updateButtonClicked))
            
            navigationItem.title = todo.title
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationItem.leftBarButtonItem = leftBarButton
            navigationItem.rightBarButtonItem = rightBarButton
        }
        else {
            let leftBarButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(leftBarButtonClicked))
            let rightBarButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonClicked))
            
            navigationItem.title = "새로운 할 일"
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationItem.leftBarButtonItem = leftBarButton
            navigationItem.rightBarButtonItem = rightBarButton
        }
    }
    
    @objc func updateButtonClicked() {
        
    }
    
    @objc func leftBarButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func addButtonClicked() {
        guard let memoTitle else {
            view.makeToast("제목을 입력해주세요", duration: 1)
            return
        }
        guard let deadline else  {
            view.makeToast("마감일을 입력해주세요", duration: 1)
            return
        }
        guard let priority else  {
            view.makeToast("우선 순위를 선택해주세요", duration: 1)
            return
        }

        todo = ToDoTable(title: memoTitle, memo: memo, deadline: stringToDate(stringDate: deadline), tag: tag, priority: priority)
        todoTableRepository.add(object: todo)
        if let image {
            saveImageToDocument(image: image, fileName: "\(todo!.id)")
        }
        dismiss(animated: true)
    }
}
