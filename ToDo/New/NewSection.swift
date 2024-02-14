//
//  NewSection.swift
//  ToDo
//
//  Created by SangRae Kim on 2/14/24.
//

import UIKit

enum NewSection: String, CaseIterable {
    case memo
    case deadline = "마감일"
    case tag = "태그"
    case priority = "우선 순위"
    case image = "이미지 추가"
    
    var nextViewController: UIViewController {
        switch self {
        case .deadline: DateViewController()
        case .tag: TagViewController()
        case .priority: PriorityViewController()
        default: ListViewController()
        }
    }
}
