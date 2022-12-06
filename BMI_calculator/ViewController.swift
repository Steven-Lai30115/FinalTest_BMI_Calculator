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
    
    }
    
    @IBAction func onDoneBtnClick(_ sender: UIButton) {
        if(bmiResultLabel.text!.isEmpty) {
            showAlert(message: "Please calculate the BMI first")
            return
        }
    }
    
    
    // create alert popup with error message
    func showAlert(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func calculateBMI(){
        switch selectedMode {
            case "Metric":
                break
            case "Imperial":
                break
            default:
                return
        }
    }
    
    
    func getAllItems(){
        do{
            let items = try context.fetch(BMIItem.fetchRequest())
        } catch {
            // Error
        }
    }
    
    func createItem(name: String){
        let newItem = BMIItem(context: context)
        // assign date to item
        
        do {
            try context.save()
        } catch {
            // Error
        }
    }
    
    func deleteItem(item: BMIItem){
        context.delete(item)
        
        do {
            try context.save()
        } catch {
            // Error
        }
    }
    
    func updateItem(item: BMIItem){
        
    }

}

