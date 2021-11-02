//
//  FinishTaskVC.swift
//  goalpost-app
//
//  Created by Hasan Elhussein on 2.11.2021.
//

import UIKit
import CoreData

class FinishTaskVC: UIViewController, UITextViewDelegate {
    
    // IBOutlets.
    @IBOutlet weak var createTaskBtn: UIButton!
    @IBOutlet weak var taskPointPckr: UIPickerView!
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    
    // Variables.
    let taskPointPckr_Data: [Int] = [1,2,3,4,5,6,7,8,9]
    var taskPoint: Int = 1
    var taskTitle: String!
    var taskDesctription: String!
    var taskPriorityType: TaskPriorityType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskDescriptionTextView.delegate = self
        taskPointPckr.delegate = self
        taskPointPckr.dataSource = self
        
        // Bind the createTask button to the keyboard using UIViewExt.
        createTaskBtn.bindToKeyboard()
    }
    
    // MARK: - Functions.
    
    @IBAction func createTaskBtnIsTapped(_ sender: Any) {
        if taskDescriptionTextView.text == "Enter a description for your goal."{
            taskDesctription = ""
        } else {
            taskDesctription = taskDescriptionTextView.text
        }
        // Pass the data to getirtodo_app coredata model.
        self.save { (complete) in
            if complete{
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func backBtnIsTapped(_ sender: Any) {
        dismissDetail()
    }
    
    // Function to initialize data coming to FinishTaskVC
    func initData(title: String, priorityType: TaskPriorityType) {
        self.taskTitle = title
        self.taskPriorityType = priorityType
    }
    
    // Clear the textview when beginning to edit. (and set the color to black).
    func textViewDidBeginEditing(_ textView: UITextView) {
        taskDescriptionTextView.text = ""
        taskDescriptionTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    // Saving to core data using completion handler.
    func save(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let task = Task(context: managedContext)
        
        task.taskTitle = taskTitle
        task.taskDescription = taskDesctription
        task.taskPriority = taskPriorityType.rawValue
        task.taskProgress = Int32(taskPoint)
        
        // Run the save function.
        do {
            try managedContext.save()
            print("Successfully saved to CoreDate")
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
    }
    
}
    
// MARK: - Extensions.

// Conforming to UIPickerViewDelegate and UIPickerViewDataSource protocols.
extension FinishTaskVC: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return taskPointPckr_Data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(taskPointPckr_Data[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        taskPoint = taskPointPckr_Data[row]
    }
    
}
