//
//  CheckTableViewCell.swift
//  ToDo
//
//  Created by SangRae Kim on 2/21/24.
//

import UIKit

class CheckTableViewCell: UITableViewCell {
    
    let iconButton: UIButton = {
        let view = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 60, weight: .light)
        let image = UIImage(systemName: "plus", withConfiguration: imageConfig)
        
        view.setImage(image, for: .normal)
        view.tintColor = .white
        view.backgroundColor = .systemBlue
        return view
    }()
    
    let nameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "목록 이름"
        view.borderStyle = .roundedRect
        view.backgroundColor = .systemGray
        view.textAlignment = .center
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
        configureHierarchy()
        configureView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CheckTableViewCell {
    func configureHierarchy() {
        contentView.addSubview(iconButton)
        contentView.addSubview(nameTextField)
    }
    
    func configureView() {
        DispatchQueue.main.async {
            self.iconButton.layer.cornerRadius = self.iconButton.frame.width / 2
        }
    }
    
    func configureConstraints() {
        iconButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.size.equalTo(80)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(iconButton.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(contentView).offset(-16)
        }
    }
}
