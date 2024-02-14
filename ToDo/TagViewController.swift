//
//  TagViewController.swift
//  ToDo
//
//  Created by SangRae Kim on 2/14/24.
//

import UIKit

class TagViewController: BaseViewController {
    
    let textField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        view.addSubview(textField)
    }
    
    override func configureView() {
        super.configureView()
        
        let rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(rightBarButtonClicked))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        textField.placeholder = "태그를 입력해주세요"
        textField.textColor = .white
        textField.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
    }
    
    override func configureConstraints() {
        textField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
    }
    
    @objc func rightBarButtonClicked() {
        NotificationCenter.default.post(name: NSNotification.Name("TagRecived"), object: nil, userInfo: ["tag": textField.text!])
        navigationController?.popViewController(animated: true)
    }
}
