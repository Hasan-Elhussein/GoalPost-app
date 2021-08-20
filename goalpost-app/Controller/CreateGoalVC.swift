//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by Hasan Elhussein on 20.08.2021.
//

import UIKit

class CreateGoalVC: UIViewController {
    
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextBtnIsTapped(_ sender: Any) {
    }
    @IBAction func shortTermBtnIsTapped(_ sender: Any) {
    }
    @IBAction func longTermBtnIsTapped(_ sender: Any) {
    }
    @IBAction func backBtnIsTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
