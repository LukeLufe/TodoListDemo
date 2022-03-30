//
//  UIImage+Expansion.swift
//  TodoListDemo
//
//  Created by Luke on 2022/3/29.
//

import UIKit

extension UIImage {
    
    static func getImageWith(color: CGColor, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext?.setFillColor(color)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
