//
//  ListTableViewCell.swift
//  ToDo
//
//  Created by SangRae Kim on 2/20/24.
//

import UIKit
import RealmSwift

class MyListTableViewCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 18)
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    
    let countLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
        contentView.addSubview(nameLabel)
        contentView.addSubview(countLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.centerY.equalTo(contentView)
            make.height.equalTo(50)
        }
        countLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.centerY.equalTo(contentView)
            make.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(item: Lists) {
        nameLabel.text = item.name
        countLabel.text = "\(item.todo.count)"
    }
}
