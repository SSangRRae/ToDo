//
//  AllListTableViewCell.swift
//  ToDo
//
//  Created by SangRae Kim on 2/15/24.
//

import UIKit
import RealmSwift

class AllListTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "제목"
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 18)
        return view
    }()
    
    let memoLabel: UILabel = {
        let view = UILabel()
        view.text = "메모"
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    let deadlineLabel: UILabel = {
        let view = UILabel()
        view.text = "마감일"
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 18)
        view.backgroundColor = .systemBlue
        return view
    }()
    
    let tagLabel: UILabel = {
        let view = UILabel()
        view.text = "태그"
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 18)
        view.backgroundColor = .systemOrange
        return view
    }()
    
    let priorityLabel: UILabel = {
        let view = UILabel()
        view.text = "우선순위"
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 18)
        view.backgroundColor = .systemGray
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(memoLabel)
        contentView.addSubview(deadlineLabel)
        contentView.addSubview(tagLabel)
        contentView.addSubview(priorityLabel)
    }
    
    func configureView(item: ToDoTable) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd"
        
        titleLabel.text = item.title
        if let memo = item.memo {
            memoLabel.text = memo
        } else {
            memoLabel.text = "없음"
        }
        deadlineLabel.text = dateFormatter.string(from: item.deadline)
        tagLabel.text = item.tag
        priorityLabel.text = item.priority
    }
    
    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(20)
            make.width.equalTo(100)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
        }
        
        deadlineLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(80)
            make.centerY.equalTo(contentView)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.leading.equalTo(deadlineLabel.snp.trailing).offset(8)
            make.centerY.equalTo(contentView)
        }
        
        priorityLabel.snp.makeConstraints { make in
            make.leading.equalTo(tagLabel.snp.trailing).offset(8)
            make.centerY.equalTo(contentView)
        }
    }
}
