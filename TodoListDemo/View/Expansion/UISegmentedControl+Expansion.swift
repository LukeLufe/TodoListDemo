//
//  UISegmentedControl+Expansion.swift
//  TodoListDemo
//
//  Created by Luke on 2022/3/29.
//

import UIKit

extension UISegmentedControl {
    
    private func removeBorder() {
        let backgroundImage = UIImage.getImageWith(color: UIColor.white.cgColor, size: bounds.size)
        setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
        setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)
        let deviderImageSize = CGSize(width: 1.0, height: bounds.size.height)
        let deviderImage = UIImage.getImageWith(color: UIColor.white.cgColor, size: deviderImageSize)
        setDividerImage(deviderImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
    
    func configUnderlineSelectedSegment(selectColor color: UIColor){
        removeBorder()
        let underlineWidth: CGFloat = bounds.size.width / CGFloat(numberOfSegments)
        let underlineHeight: CGFloat = 2.0
        let underLineYPosition = bounds.size.height - underlineHeight
        let underlineFrame = CGRect(x: 0.0, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = color
        underline.tag = 1
        addSubview(underline)
        setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
        setTitleTextAttributes([.foregroundColor: color], for: .selected)
    }
    
    func changeUnderlinePosition(){
        guard let underline = viewWithTag(1) else {
            return
        }
        let underlineFinalXPosition = (bounds.width / CGFloat(numberOfSegments)) * CGFloat(selectedSegmentIndex)
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1, delay: 0.0) {
            underline.frame.origin.x = underlineFinalXPosition
        }
    }
    
}
