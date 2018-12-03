//
//  TableViewController.swift
//  NoteBook (To Do List)
//
//  Created by Igor Shelginskiy on 11/23/18.
//  Copyright © 2018 Igor Shelginskiy. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, ToDoCellDelegate {
    func checkmarTapped(sender: ToDoCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        var todo = todos[indexPath.row]
        todo.isComplete = !todo.isComplete
        todos[indexPath.row] = todo
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    

    var todos = [ToDo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todos = ToDo.loadToDos() ?? []

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        navigationItem.leftBarButtonItem = editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell

        let todo = todos[indexPath.row]
        cell.delegate = self
        cell.titleLabel.text = todo.title
        cell.isCompleteButton.isSelected = todo.isComplete

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "showDetails" else {return}
        
        guard let todoViewController = segue.destination as? ToDoViewController else {return}
        
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        
        let todo = todos[indexPath.row]
        todoViewController.todo = todo
        todoViewController.navigationItem.title = "Edit To Do Item"
        
    }
    

    @IBAction func unwindCancel(cancelSegue: UIStoryboardSegue){
    }
    
    @IBAction func unwindSave(saveSegue: UIStoryboardSegue) {
        guard let sourceViewController = saveSegue.source as? ToDoViewController else {return}
        
        guard let todo = sourceViewController.todo else {return}
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            //editing existing item
            todos[selectedIndexPath.row] = todo
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            //adding new item
            let newIndexPath = IndexPath(row: todos.count, section: 0)
            todos.append(todo)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
}

