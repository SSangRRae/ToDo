//
//  MemoTableViewCell.swift
//  ToDo
//
//  Created by SangRae Kim on 2/14/24.
//

import UIKit
import SnapKit

class MemoTableViewCell: UITableViewCell {

    let titleTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "제목"
        view.borderStyle = .none
        view.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
        view.textColor = .white
        return view
    }()
    let memoTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "메모"
        view.borderStyle = .none
        view.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
        view.textColor = .white
        return view
    }()
    
    var titleClosure: ((String) -> Void)!
    var memoClosure: ((String) -> Void)!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MemoTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if textField == titleTextField { titleClosure(text) }
        else { memoClosure(text) }
    }
}

extension MemoTableViewCell {
    func configureHierarchy() {
        contentView.addSubview(titleTextField)
        contentView.addSubview(memoTextField)
    }
    
    func configureView() {
        contentView.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
        selectionStyle = .none
        titleTextField.delegate = self
        memoTextField.delegate = self
    }
    
    func configureConstraints() {
        titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        memoTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
    }
}
