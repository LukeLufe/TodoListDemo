//
//  WorkManager.swift
//  TodoListDemo
//
//  Created by Luke on 2022/3/30.
//

import Foundation

struct WorkManager {
    
    // MARK: Queue For Synchronous
    let queue = DispatchQueue(label: "com.workManager.queue")
    
    func submitWork(text: String, completion: @escaping (Work?, Error?) -> ()) {
        queue.sync {
            // Do Real Work...
            let work = Work(text: text)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                completion(work ,nil)
            }
        }
    }
    
    func updateWork(_ work: Work, completion: @escaping (Work?, Error?) -> ()) {
        queue.sync {
            // Do Real Work...
            var newWork = work
            newWork.date = Date()
            newWork.isFinish = true
            completion(newWork ,nil)
        }
    }
    
    func deleteWork(_ work: Work, completion: @escaping (Error?) -> ()) {
        queue.sync {
            // Do Real Work...
            completion(nil)
        }
    }
    
}
