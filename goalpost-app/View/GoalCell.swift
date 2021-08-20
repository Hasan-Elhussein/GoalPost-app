//
//  GoalCell.swift
//  goalpost-app
//
//  Created by Hasan Elhussein on 8.08.2021.
//

import UIKit

class GoalCell: UITableViewCell {
    
    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    
    func configureCell(goalDescription: String, goaltype: GoalType, progress: Int){
        self.goalDescriptionLbl.text = goalDescription
        self.goalTypeLbl.text = goaltype.rawValue
        self.goalProgressLbl.text = String(progress)
    }

}
