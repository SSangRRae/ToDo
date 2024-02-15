//
//  ListSection.swift
//  ToDo
//
//  Created by SangRae Kim on 2/15/24.
//

import UIKit

enum ListSection: String, CaseIterable {
    case today = "오늘"
    case plan = "예정"
    case all = "전체"
    case flag = "깃발"
    case complete = "완료"
    
    var image: UIImage {
        switch self {
        case .today: UIImage(systemName: "15.square")!
        case .plan: UIImage(systemName: "calendar")!
        case .all: UIImage(systemName: "tray.fill")!
        case .flag: UIImage(systemName: "flag.fill")!
        case .complete: UIImage(systemName: "checkmark")!
        }
    }
    
    var color: UIColor {
        switch self {
        case .today: UIColor.systemBlue
        case .plan: UIColor.systemOrange
        case .all: UIColor.systemGray
        case .flag: UIColor.systemYellow
        case .complete: UIColor.systemGreen
        }
    }
}
