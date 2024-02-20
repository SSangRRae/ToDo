//
//  ListCollectionViewCell.swift
//  ToDo
//
//  Created by SangRae Kim on 2/15/24.
//

import UIKit

class ToDoCollectionViewCell: UICollectionViewCell {
    
    let imageButton: UIButton = {
        let view = UIButton()
        view.tintColor = .white
        return view
    }()
    let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 17)
        view.textAlignment = .center
        return view
    }()
    let countLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 30)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
        layer.cornerRadius = 10
        configureHierarchy()
        configureConstraints()
        
        DispatchQueue.main.async {
            self.imageButton.layer.cornerRadius = self.imageButton.frame.width / 2
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        addSubview(imageButton)
        addSubview(titleLabel)
        addSubview(countLabel)
    }
    
    func configureViews(item: MainSection) {
        imageButton.setImage(item.image, for: .normal)
        imageButton.backgroundColor = item.color
        titleLabel.text = item.rawValue
        countLabel.text = "\(item.count)"
    }
    
    func configureConstraints() {
        imageButton.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.size.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageButton.snp.bottom).offset(8)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.width.equalTo(imageButton.snp.width)
            make.height.equalTo(22)
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
}
