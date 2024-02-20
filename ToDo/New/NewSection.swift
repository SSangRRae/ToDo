//
//  NewSection.swift
//  ToDo
//
//  Created by SangRae Kim on 2/14/24.
//

import UIKit

enum NewSection: Int, CaseIterable {
    case memo = 0
    case deadline
    case tag
    case priority
    case image
    
    var title: String {
        switch self {
        case .memo: ""
        case .deadline: "마감일"
        case .tag: "태그"
        case .priority: "우선 순위"
        case .image: "이미지 추가"
        }
    }
    
    var height: CGFloat {
        switch self {
        case .memo: 150
        default: 50
        }
    }
}

enum ViewController {
    case new
    case list
}
