//
//  ToDo.swift
//  NoteBook (To Do List)
//
//  Created by Igor Shelginskiy on 11/23/18.
//  Copyright © 2018 Igor Shelginskiy. All rights reserved.
//

import Foundation

struct ToDo: Codable { //все простые типы удовлетворяют протоколу Кодабл и в этом случае мы задать данный протокол к структуре для сохранения данных в plist
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let archivURL = documentsDirectory.appendingPathComponent("todos").appendingPathExtension("plist")
    
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    static func loadToDos() -> [ToDo]? {
        guard let codedToDo = try? Data(contentsOf: archivURL) else { return nil }
        
        let propertyListDecoder = PropertyListDecoder()
        
        guard let todos = try? propertyListDecoder.decode([ToDo].self, from: codedToDo) else { return nil }
        return todos
    }
    static func saveTodos(_ todos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(todos)
        try? codedToDos?.write(to: archivURL, options: .noFileProtection)
    }
    
    static func loadSampleToDos() -> [ToDo] {
        return [
            ToDo(title: "Buy milk", isComplete: false, dueDate: Date(), notes: nil),
            ToDo(title: "Buy bread", isComplete: false, dueDate: Date(), notes: nil),
            ToDo(title: "Buy tickets", isComplete: false, dueDate: Date(), notes: nil),
        ]
    }
}
