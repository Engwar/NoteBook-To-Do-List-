//
//  ToDoViewController.swift
//  NoteBook (To Do List)
//
//  Created by Igor Shelginskiy on 11/27/18.
//  Copyright © 2018 Igor Shelginskiy. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titletextField: UITextField!
    @IBOutlet weak var dueDataLabel: UILabel!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var notesTextField: UITextView!
    
    var isPickerHidden = true {
        didSet {
            dueDatePicker.isHidden = isPickerHidden
        }
    }
    
    var todo: ToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dueDatePicker.isHidden = isPickerHidden
        updateUI()
        updateSaveButtonState()
        updateDueDateLabel(date: dueDatePicker.date)
    }
    
    func updateSaveButtonState() {
        let text = titletextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    func updateDueDateLabel(date:Date) {
        dueDataLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    func updateUI() {
        if let todo = todo {
        titletextField.text = todo.title
        isCompleteButton.isSelected = todo.isComplete
        dueDatePicker.date = todo.dueDate
        notesTextField.text = todo.notes
        } else {
            dueDatePicker.date = Date().addingTimeInterval(24 * 60 * 60)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        switch indexPath {
        case [0, 2]: return isPickerHidden ? 0 : largeCellHeight
        case [1, 0]: return largeCellHeight
        default: return normalCellHeight
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titletextField.text ?? ""
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePicker.date
        let notes = notesTextField.text
        
        todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0, 1]:
            isPickerHidden = !isPickerHidden
            dueDataLabel.textColor = isPickerHidden ? .black : tableView.tintColor
            tableView.beginUpdates()
            tableView.endUpdates()
        default: break
        }
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    @IBAction func returnPressed(_ sender: UITextField) {
        titletextField.resignFirstResponder()
    }
    @IBAction func isCompleteButtontapped(_ sender: UIButton) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePicker.date)
    }
    
}
