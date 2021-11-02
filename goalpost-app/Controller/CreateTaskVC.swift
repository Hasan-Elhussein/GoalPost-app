//
//  CreateTaskVC.swift
//  goalpost-app
//
//  Created by Hasan Elhussein on 2.11.2021.
//

import UIKit

class CreateTaskVC: UIViewController, UITextViewDelegate {
    
    // IBOutlets.
    @IBOutlet weak var taskTextView: UITextView!
    @IBOutlet weak var lowPriorityBtn: UIButton!
    @IBOutlet weak var midiumPriotiyBtn: UIButton!
    @IBOutlet weak var highPriorityBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    // Variables
    var taskPriorityType = TaskPriorityType.lowPriority
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Bind the NEXT button to the keyboard using the UIViewExt
        nextBtn.bindToKeyboard()
        
        // Set the colors of the buttons accordingly.
        lowPriorityBtn.setSelectedColor()
        midiumPriotiyBtn.setDeselectedColor()
        highPriorityBtn.setDeselectedColor()
        
        // Set the delegate of taskTextView to self
        taskTextView.delegate = self
    }
    
    // MARK: - Functions.
    @IBAction func nextBtnIsTapped(_ sender: Any) {
        if taskTextView.text != "" && taskTextView.text != "What's the Title of your goal?" {
            guard let finishTaskVC = storyboard?.instantiateViewController(withIdentifier: "FinishTaskVC") as? FinishTaskVC else { return }
            finishTaskVC.initData(title: taskTextView.text!, priorityType: taskPriorityType)
            // Dismiss this ViewController and present the new one at the same time.
            presentingViewController?.presentSecondaryDetail(finishTaskVC)
        }
    }
    @IBAction func backBtnIsTapped(_ sender: Any) {
        // Dismiss the CreateTaskVC when this button is tapped
        dismissDetail()
    }
    
    // Clear the textview when beginning to edit. (and set the color to black).
    func textViewDidBeginEditing(_ textView: UITextView) {
        taskTextView.text = ""
        taskTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    // MARK: - Set the colors of the buttons accordingly.
    @IBAction func lowPriorityBtnIsTapped(_ sender: Any) {
        taskPriorityType = .lowPriority
        lowPriorityBtn.setSelectedColor()
        midiumPriotiyBtn.setDeselectedColor()
        highPriorityBtn.setDeselectedColor()
    }
    @IBAction func mediumPriorityBtnIsTapped(_ sender: Any) {
        taskPriorityType = .midiumPriority
        lowPriorityBtn.setDeselectedColor()
        midiumPriotiyBtn.setSelectedColor()
        highPriorityBtn.setDeselectedColor()
    }
    @IBAction func highPriorityBtnIsTapped(_ sender: Any) {
        taskPriorityType = .highPriority
        lowPriorityBtn.setDeselectedColor()
        midiumPriotiyBtn.setDeselectedColor()
        highPriorityBtn.setSelectedColor()
    }

}
