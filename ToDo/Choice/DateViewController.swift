//
//  DateViewController.swift
//  ToDo
//
//  Created by SangRae Kim on 2/14/24.
//

import UIKit

class DateViewController: BaseViewController {
    
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        view.addSubview(datePicker)
    }
    
    override func configureView() {
        super.configureView()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        let rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(rightBarButtonClicked))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    override func configureConstraints() {
        datePicker.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func rightBarButtonClicked() {
        NotificationCenter.default.post(name: NSNotification.Name("deadline"), object: nil, userInfo: ["deadline": dateToString(date: datePicker.date)])
        navigationController?.popViewController(animated: true)
    }
}
