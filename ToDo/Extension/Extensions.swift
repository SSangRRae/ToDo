//
//  UIViewController+Extension.swift
//  ToDo
//
//  Created by SangRae Kim on 2/19/24.
//

import UIKit

extension UIViewController {
    
    func saveImageToDocument(image: UIImage, fileName: String) {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent("\(fileName).jpg")
        
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("file save error", error)
        }
    }
    
    func loadImageToDocument(fileName: String) -> UIImage? {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let fileURL = documentDirectory.appendingPathComponent("\(fileName).jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path())
        }
        return nil
    }
    
    func removeImageFromDocument(filename: String) {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path())
            } catch {
                print("image remove filed")
            }
        } else {
            print("image not found")
        }
    }
    
    func dateToString(date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date else { return "" }
        return dateFormatter.string(from: date)
    }
    
    func stringToDate(stringDate: String) -> Date {
        let dateFormatter = DateFormatter()
        return dateFormatter.date(from: stringDate) ?? Date()
    }
}

extension UIView: ConfigIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
    
    func loadImageToDocument(fileName: String) -> UIImage? {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let fileURL = documentDirectory.appendingPathComponent("\(fileName).jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path())
        }
        return nil
    }
}
