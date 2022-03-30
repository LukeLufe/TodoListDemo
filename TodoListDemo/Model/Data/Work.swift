//
//  Work.swift
//  TodoListDemo
//
//  Created by Luke on 2022/3/29.
//

import Foundation

struct Work {
    
    var id: String = UUID().uuidString
    var text: String
    var date: Date = Date()
    var isFinish: Bool = false
    
}
