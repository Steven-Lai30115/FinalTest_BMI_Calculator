//
//  ViewController.swift
//  BMI_calculator
//
//  Created by chin wai lai on 5/12/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var modeTextField: UILabel!
    @IBOutlet weak var bmiResultLabel: UILabel!
    @IBOutlet weak var bmiCategoryLabel: UILabel!
    
    
    @IBOutlet weak var WeightTitle: UILabel!
    @IBOutlet weak var HeightTitle: UILabel!
    var currentItem: BMIItem?
    
    var selectedGender: String = "Male"
    var selectedMode: String = "Metric"
    var calculateResult: Float = 0.0
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modeTextField.text = selectedMode
        genderLabel.text =  selectedGender
        WeightTitle.text = "Weight(kg)"
        HeightTitle.text = "Height(m)"
        
    }
    
    // switching gender
    @IBAction func onGenderSwitch(_ sender: UISwitch) {
        if(selectedGender == "Male"){
            selectedGender = "Female"
        } else {
            selectedGender = "Male"
        }
        genderLabel.text =  selectedGender
    }
    
    // switch calculate mode
    @IBAction func onModeSwitch(_ sender: UISwitch) {
        if(selectedMode == "Metric"){
            selectedMode = "Imperial"
            WeightTitle.text = "Weight(pound)"
            HeightTitle.text = "Height(inch)"
        } else{
            selectedMode = "Metric"
            WeightTitle.text = "Weight(kg)"
            HeightTitle.text = "Height(m)"
        }
        modeTextField.text = selectedMode
    }
    
    @IBAction func onCalculateBtnClick(_ sender: UIButton) {
        if(weightTextField.text!.isEmpty || heightTextField.text!.isEmpty){
            showAlert(message: "Please Enter Valid Weight and Height number.")
            return
        }
    
        calculateBMI()
    }
    
    @IBAction func onDoneBtnClick(_ sender: UIButton) {
        if(bmiResultLabel.text!.isEmpty) {
            showAlert(message: "Please calculate the BMI first")
            return
        }
        createItem()
    }
    
    
    // create alert popup with error message
    func showAlert(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // calculate the BMI and round the result to two decimal places
    func calculateBMI(){
        switch selectedMode {
            case "Metric":
                calculateResult = (Float(weightTextField.text!)!) / ((Float(heightTextField.text!)! ) * (Float(heightTextField.text!)!))
                break
            case "Imperial":
                calculateResult = (Float(weightTextField.text!)! * 703) / ((Float(heightTextField.text!)! ) * (Float(heightTextField.text!)!))
                break
            default:
                return
        }
        
        calculateResult = round(calculateResult * 100) / 100.0
        bmiCategoryLabel.text = getCategory(value: calculateResult)
        bmiResultLabel.text = String(calculateResult)
    }
    
    
    // return the category string based on the input value
    func getCategory(value: Float) -> String{
        if(value < 16){
            return "Severe Thinness"
        } else if (value >= 16 && value < 17){
            return "Moderate Thinness"
        } else if (value >= 17 && value < 18.5){
            return "Mild Thinness"
        } else if (value >= 18.5 && value < 25){
            return "Normal"
        } else if (value >= 25 && value < 30){
            return "Overweight"
        } else if (value >= 30 && value < 35){
            return "Obese Class I"
        } else if (value >= 35 && value < 40){
            return "Obese Class II"
        } else if (value > 40) {
            return "Obese Class III"
        }
        return ""
    }
    
   
    
    // Create core data item
    func createItem(){
        let newItem = BMIItem(context: context)
        // assign date to item
        newItem.bmi = calculateResult
        newItem.weight = Float(weightTextField.text!)!
        newItem.height = Float(heightTextField.text!)!
        newItem.mode = selectedMode
        newItem.date = Date()
        do {
            try context.save()
        } catch {
            // Error
        }
    }
}

extension String {
    var isNumber: Bool {
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }
}
