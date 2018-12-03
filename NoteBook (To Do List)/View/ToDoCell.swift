//
//  ToDoCell.swift
//  NoteBook (To Do List)
//
//  Created by Igor Shelginskiy on 11/30/18.
//  Copyright © 2018 Igor Shelginskiy. All rights reserved.
//

import UIKit

protocol ToDoCellDelegate {
    func checkmarTapped (sender: ToDoCell)
}

class ToDoCell: UITableViewCell {
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var delegate: ToDoCellDelegate?
    
    @IBAction func completeButtonTapped() {
        delegate?.checkmarTapped(sender: self)
    }
}
