//
//  TrackingTableViewCell.swift
//  BMI_calculator
//
//  Created by chin wai lai on 5/12/2022.
//

import UIKit

class TrackingTableViewCell: UITableViewCell {

    
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    func set(bmi: Float, weight: Float, date: Date){
        bmiLabel.text = String(bmi)
        weightLabel.text = String(weight)
        dateLabel.text = date.formatted()
    }
    
}
