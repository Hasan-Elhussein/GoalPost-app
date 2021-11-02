//
//  TasksVC.swift
//  goalpost-app
//
//  Created by Hasan Elhussein on 2.11.2021.
//

import UIKit
import CoreData

// Create a constant that is accessable publically by all the other ViewControllers.
let appDelegate = UIApplication.shared.delegate as? AppDelegate

class TasksVC: UIViewController {
    // IBOutlets.
    @IBOutlet weak var tableView: UITableView!
    
    // Variables.
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting the tableView delegate and dataSource to self.
        tableView.delegate = self
        tableView.dataSource = self
        
        // Show the tableView
        tableView.isHidden = false

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        tableView.reloadData()
    }
    
    // MARK: - Functions.
    
    @IBAction func addTaskButtonIsTapped(_ sender: Any) {
        // Use the custom animation to present the CreateTaskVC.
        guard let creatTaskVC = storyboard?.instantiateViewController(withIdentifier: "CreateTaskVC") else{ return }
        
        presentDetail(creatTaskVC)
    }
    
    @IBAction func refreshBtnIsTapped(_ sender: Any) {
        fetchCoreDataObjects()
        tableView.reloadData()
    }
    
    func fetchCoreDataObjects(){
        self.fetch { (complete) in
            if complete{
                if tasks.count >= 1 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            }
        }
    }
    
}

// MARK: - Extensins.

// Conforming to UITableViewDelegate and UITableViewDataSource protocols.
extension TasksVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeuing a reusable cell with identifier "taskCell",
        // If we don't get the wanted cell; the code will return a blank cell.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") as? TaskCell else {
            return UITableViewCell()
        }
        
        let task = tasks[indexPath.row]
        
        // Configuring the cell.
        cell.configureCell(task: task)
        return cell
    }
    
    // Enable the tableView to be able to swipe and edit cells.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { rowAction, indexPath in
            self.removeTask(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let subAction = UITableViewRowAction (style: .normal, title: "SUB 1") { (rowAction, indexPath) in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        subAction.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.662745098, blue: 0.2666666667, alpha: 1)
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        return [deleteAction, subAction]
    }
    
    // When a task cell is selected, pass an object of that task to the UpdateTaskVC and perform a segue.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "UpdateTaskVC", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UpdateTaskVC" && tableView.indexPathForSelectedRow != nil {
            let indexPath = tableView.indexPathForSelectedRow!
            let updateTaskVC = segue.destination as? UpdateTaskVC
            let selectedTask: Task!
            selectedTask = tasks[indexPath.row]
            updateTaskVC?.selectedTask = selectedTask
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

}

// MARK: - Extensions for CoreData
extension TasksVC {
    // Set progress function.
    func setProgress(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let chosenTask = tasks[indexPath.row]
        if chosenTask.taskProgress > 0 {
            chosenTask.taskProgress -= 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
            print("Sucessfully set progress.")
        } catch {
            debugPrint("Could not set progress: \(error.localizedDescription)")
        }
    }
    
    // Fetch data from CoreData.
    func fetch(completion: (_ complete: Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        do {
            tasks = try managedContext.fetch(fetchRequest)
            print("Successfully fetched data.")
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    // Remove data from CoreData.
    func removeTask(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        managedContext.delete(tasks[indexPath.row])
        do {
            try managedContext.save()
            print("Successfully removed task.")
        } catch {
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
        
    }
}
