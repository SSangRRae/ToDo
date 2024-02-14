//
//  PriorityViewController.swift
//  ToDo
//
//  Created by SangRae Kim on 2/14/24.
//

import UIKit

class PriorityViewController: BaseViewController {
    
    let segmentedControl = UISegmentedControl()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        view.addSubview(segmentedControl)
    }
    
    override func configureView() {
        super.configureView()
        
        let rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(rightBarButtonClicked))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        segmentedControl.backgroundColor = .white
        segmentedControl.insertSegment(withTitle: "필수", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "기본", at: 1, animated: true)
    }
    
    override func configureConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
    }
    
    @objc func rightBarButtonClicked() {
        NotificationCenter.default.post(name: NSNotification.Name("PriorityRecived"), object: nil, userInfo: ["priority": segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)!])
        navigationController?.popViewController(animated: true)
    }
}
