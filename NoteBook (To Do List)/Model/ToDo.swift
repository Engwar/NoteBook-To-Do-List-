//
//  ToDo.swift
//  NoteBook (To Do List)
//
//  Created by Igor Shelginskiy on 11/23/18.
//  Copyright © 2018 Igor Shelginskiy. All rights reserved.
//

import Foundation

struct ToDo {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static func loadToDos() -> [ToDo]? {
        return loadSampleToDos()
    }
    
    static func loadSampleToDos() -> [ToDo] {
        return [
            ToDo(title: "Buy milk", isComplete: false, dueDate: Date(), notes: nil),
            ToDo(title: "Buy bread", isComplete: false, dueDate: Date(), notes: nil),
            ToDo(title: "Buy tickets", isComplete: false, dueDate: Date(), notes: nil),
        ]
    }
}
