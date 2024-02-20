//
//  InfoTableViewCell.swift
//  ToDo
//
//  Created by SangRae Kim on 2/14/24.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 16)
        return view
    }()
    
    let subTitleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 15)
        return view
    }()
    
    let selectedImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let rightImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = .white
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
        
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(selectedImageView)
        contentView.addSubview(rightImage)
    }
    
    func configureView() {
        
    }
    
    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView.snp.leading).offset(16)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(rightImage.snp.leading).offset(-16)
            make.height.equalTo(50)
        }
        
        selectedImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(rightImage.snp.leading).offset(-16)
            make.width.equalTo(70)
            make.height.equalTo(50)
        }
        
        rightImage.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.size.equalTo(20)
        }
    }
    
    func configureCell(title: String, subTitle: String?, image: UIImage?) {
        titleLabel.text = title
        if subTitle == nil {
            selectedImageView.image = image
        } else {
            subTitleLabel.text = subTitle
        }
    }
}
