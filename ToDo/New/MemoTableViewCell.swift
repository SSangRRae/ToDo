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
    let memoTextView: UITextView = {
        let view = UITextView()
        view.text = "메모"
        view.borderStyle = .none
        view.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
        view.textColor = .white
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
        contentView.addSubview(titleTextField)
        contentView.addSubview(memoTextView)
        selectionStyle = .none
        titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
