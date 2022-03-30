//
//  String+Expansion.swift
//  TodoListDemo
//
//  Created by Luke on 2022/3/29.
//

import UIKit

extension String {
    
    enum IndexLocation {
        case first, last
    }
    
    func insertRedStar(at location: IndexLocation) -> NSMutableAttributedString {
        let starString: String
        let startIndex: Int
        if location == .first {
            starString = "*" + self
            startIndex = 0
        } else {
            starString = self + "*"
            startIndex = count
        }
        let attrString = NSMutableAttributedString(string: starString)
        attrString.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange.init(location: startIndex, length: 1))
        return attrString
    }
    
}
