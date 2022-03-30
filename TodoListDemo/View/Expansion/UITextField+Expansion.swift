//
//  UITextField+Expansion.swift
//  TodoListDemo
//
//  Created by Luke on 2022/3/29.
//

import UIKit

extension UITextField {
    
    func configBorderColor(_ color: CGColor) {
        layer.borderWidth = (color == UIColor.clear.cgColor) ? 0 : 1
        layer.borderColor = color
    }
    
}
