//
//  UpdateTaskVC.swift
//  goalpost-app
//
//  Created by Hasan Elhussein on 2.11.2021.
//

import UIKit
import CoreData

class UpdateTaskVC: UIViewController {
    // IBOutlets.
    @IBOutlet weak var taskTitleTextView: UITextView!
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    @IBOutlet weak var lowPriorityBtn: UIButton!
    @IBOutlet weak var midPriorityBtn: UIButton!
    @IBOutlet weak var highPriorityBtn: UIButton!
    @IBOutlet weak var updateBtn: UIButton!
    
    // Variables.
    var taskPriority: TaskPriorityType!
    var selectedTask: Task? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Bind updateBtn to the top of the keyboard.
        updateBtn.bindToKeyboard()
        
        taskTitleTextView.text = selectedTask?.taskTitle
        taskDescriptionTextView.text = selectedTask?.taskDescription
        
        // Show the selectedTask priority.
        switch selectedTask?.taskPriority{
        case TaskPriorityType.lowPriority.rawValue:
            taskPriority = .lowPriority
            lowPriorityBtn.setSelectedColor()
            midPriorityBtn.setDeselectedColor()
            highPriorityBtn.setDeselectedColor()
        case TaskPriorityType.midiumPriority.rawValue:
            taskPriority = .midiumPriority
            midPriorityBtn.setSelectedColor()
            lowPriorityBtn.setDeselectedColor()
            highPriorityBtn.setDeselectedColor()
        case TaskPriorityType.highPriority.rawValue:
            taskPriority = .highPriority
            highPriorityBtn.setSelectedColor()
            lowPriorityBtn.setDeselectedColor()
            midPriorityBtn.setDeselectedColor()
        default:
            return
        }
    }
    
    // MARK: - Functions.
    
    @IBAction func lowBtnIsTapped(_ sender: Any) {
        taskPriority = .lowPriority
        lowPriorityBtn.setSelectedColor()
        midPriorityBtn.setDeselectedColor()
        highPriorityBtn.setDeselectedColor()
    }
    @IBAction func midBtnIsTapped(_ sender: Any) {
        taskPriority = .midiumPriority
        midPriorityBtn.setSelectedColor()
        lowPriorityBtn.setDeselectedColor()
        highPriorityBtn.setDeselectedColor()
    }
    @IBAction func highBtnIsTapped(_ sender: Any) {
        taskPriority = .highPriority
        highPriorityBtn.setSelectedColor()
        lowPriorityBtn.setDeselectedColor()
        midPriorityBtn.setDeselectedColor()
    }
    
    @IBAction func updateBtnIsTapped(_ sender: Any) {
        guard let managedContext: NSManagedObjectContext = appDelegate?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
            do {
                let results: NSArray = try managedContext.fetch(fetchRequest) as NSArray
                for result in results {
                    let task = result as! Task
                    if (task == selectedTask) && (taskTitleTextView.text != "") {
                        task.taskTitle = taskTitleTextView.text
                        task.taskDescription = taskDescriptionTextView.text
                        task.taskPriority = taskPriority.rawValue
                        try managedContext.save()
                        print("Data Updated Successfully.")
                    }
                }
            } catch {
                debugPrint("Error at updating: \(error.localizedDescription)")
            }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backBtnIsTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
