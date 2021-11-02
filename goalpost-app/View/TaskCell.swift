//
//  TaskCell.swift
//  goalpost-app
//
//  Created by Hasan Elhussein on 2.11.2021.
//

import UIKit

class TaskCell: UITableViewCell {
    
    // IBOutlets for the labels in the cell.
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskPriorityLbl: UILabel!
    @IBOutlet weak var taskProgressLbl: UILabel!
    @IBOutlet weak var completionView: UIView!
    
    // A function to configure the cell.
    func configureCell(task: Task){
        self.taskTitle.text = task.taskTitle
        self.taskPriorityLbl.text = task.taskPriority
        self.taskProgressLbl.text = String(task.taskProgress)
        
        if task.taskProgress == 0 {
            self.completionView.isHidden = false
        } else {
            self.completionView.isHidden = true
        }
    }
    
}
