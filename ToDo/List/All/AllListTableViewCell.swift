//
//  AllListTableViewCell.swift
//  ToDo
//
//  Created by SangRae Kim on 2/15/24.
//

import UIKit
import RealmSwift

class AllListTableViewCell: UITableViewCell {
    
    let completeButton: UIButton = {
        let view = UIButton()
        view.tintColor = .white
        return view
    }()
    
    let priorityImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 18)
        return view
    }()
    
    let memoLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    let deadlineLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    let tagLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(completeButton)
        contentView.addSubview(priorityImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(memoLabel)
        contentView.addSubview(deadlineLabel)
        contentView.addSubview(tagLabel)
    }
    
    func configureView(item: ToDoTable) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd"
        
        if item.complete {
            completeButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        } else {
            completeButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        
        if item.priority == "높음" {
            priorityImage.image = UIImage(systemName: "exclamationmark.3")
        } else if item.priority == "중간" {
            priorityImage.image = UIImage(systemName: "exclamationmark.2")
        } else {
            priorityImage.image = UIImage(systemName: "exclamationmark")
        }
        
        titleLabel.text = item.title
        if let memo = item.memo {
            memoLabel.text = memo
        } else {
            memoLabel.text = ""
        }
        deadlineLabel.text = dateFormatter.string(from: item.deadline)
        
        if let tag = item.tag {
            tagLabel.text = "#\(tag)"
        } else {
            tagLabel.text = ""
        }
    }
    
    func configureConstraints() {
        completeButton.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView).offset(8)
            make.size.equalTo(30)
        }
        
        priorityImage.snp.makeConstraints { make in
            make.centerY.equalTo(completeButton)
            make.leading.equalTo(completeButton.snp.trailing).offset(8)
            make.size.equalTo(15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(priorityImage)
            make.leading.equalTo(priorityImage.snp.trailing).offset(8)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(priorityImage.snp.leading)
        }
        
        deadlineLabel.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(8)
            make.leading.equalTo(priorityImage.snp.leading)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(deadlineLabel.snp.top)
            make.leading.equalTo(deadlineLabel.snp.trailing).offset(8)
        }
    }
}
