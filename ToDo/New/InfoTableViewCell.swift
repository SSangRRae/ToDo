//
//  InfoTableViewCell.swift
//  ToDo
//
//  Created by SangRae Kim on 2/14/24.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
        tintColor = .white
        accessoryType = .disclosureIndicator
        textLabel?.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(title: String, subTitle: String?) {
        textLabel?.text = title
        guard let subTitle else {
            return
        }
        detailTextLabel?.text = subTitle
    }
}
