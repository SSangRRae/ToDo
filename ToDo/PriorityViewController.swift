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
        segmentedControl.insertSegment(withTitle: "높음", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "중간", at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: "낮음", at: 2, animated: true)
        segmentedControl.selectedSegmentIndex = 0
    }
    
    override func configureConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
    }
    
    @objc func rightBarButtonClicked() {
        if let title = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex) {
            NotificationCenter.default.post(name: NSNotification.Name("PriorityRecived"), object: nil, userInfo: ["priority": title])
        }
        navigationController?.popViewController(animated: true)
    }
}
