//
//  Date+Expansion.swift
//  TodoListDemo
//
//  Created by Luke on 2022/3/29.
//

import Foundation

extension Date {
    
    func formatOfOneDay() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Asia/Taipei")
        formatter.dateFormat = "yyyy-MM-dd"
        let nowTimeInterval = Date().timeIntervalSince1970
        let intervalTimeInterval = nowTimeInterval - timeIntervalSince1970
        if intervalTimeInterval.hours >= 24 {
            return formatter.string(from: self)
        } else {
            return intervalTimeInterval.getTimeString() + "前"
        }
    }
    
}

extension TimeInterval {
    
    var hours: Int {
        Int(self.rounded(.toNearestOrAwayFromZero)) / 3600
    }
    
    func getTimeString() -> String {
        let seconds = Int(self.rounded(.toNearestOrAwayFromZero))
        if seconds < 60 {
            return "\(seconds)秒"
        } else if seconds < 3600 {
            return "\(seconds / 60)分鐘"
        } else {
            return "\(seconds / 3600)小時"
        }
    }
    
}
