//
//  WorkoutViewCell.swift
//  Run
//
//  Created by Douglas Taquary on 15/04/18.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit

class WorkoutViewCell: UITableViewCell {
    
    @IBOutlet weak var workoutDate: UILabel!
    @IBOutlet weak var workoutRoute: UILabel!
    @IBOutlet weak var workoutDistance: UILabel!
    @IBOutlet weak var workoutTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with fitness: Fitness) {
        workoutDate.text = "\(fitness.date)"
        workoutRoute.text = "Av. Raul Lopes"
        workoutDistance.text = "\(fitness.distance)"
        workoutTime.text = "00:00"
    }


}
