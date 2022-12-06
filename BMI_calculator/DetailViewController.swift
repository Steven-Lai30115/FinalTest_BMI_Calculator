//
//  DetailViewController.swift
//  BMI_calculator
//
//  Created by chin wai lai on 6/12/2022.
//

import UIKit

class DetailViewController: UIViewController {

    public var item: BMIItem? = nil
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var modeTextField: UILabel!
    @IBOutlet weak var bmiTextField: UILabel!
    @IBOutlet weak var modeSwitch: UISwitch!
    
    @IBOutlet weak var WeightLabel: UILabel!
    @IBOutlet weak var HeightLabel: UILabel!
    var calculateResult: Float = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()

        setDatePicker()
        
        if(item != nil){
            dateTextField.text = item!.date?.formatted()
            heightTextField.text = String(item!.height)
            weightTextField.text = String(item!.weight)
            calculateResult = item!.bmi
            bmiTextField.text =  String(item!.bmi)
            modeSwitch.isOn = item!.mode == "Metric"
            
            displayModeText()
        }
    }
    
    func displayModeText(){
        if(item!.mode == "Metric"){
            WeightLabel.text = "Weight (kg)"
            HeightLabel.text = "Height (m)"
        } else {
            WeightLabel.text = "Weight (pound)"
            HeightLabel.text = "Height (inch)"
        }
        modeTextField.text = item!.mode
    }
    
    @IBAction func onCalculateBtnClick(_ sender: UIButton) {
        
    }
    
    @IBAction func onModeSwitch(_ sender: UISwitch) {
        if(item!.mode == "Metric"){
            item!.mode = "Imperial"
        } else {
            item!.mode = "Metric"
        }
        
        displayModeText()
    }
    
    // set date picker target to dateTextField, allow to update the record date
    func setDatePicker(){
        
        let datePicker = UIDatePicker()
        datePicker.date = Date()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .compact
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for:
                                UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 250)
        datePicker.contentHorizontalAlignment = .center
        dateTextField.inputView = datePicker
    }
    
    @objc func dateChange(datePicker: UIDatePicker){
        dateTextField.text = formatDate(date: datePicker.date)
        item!.date = datePicker.date
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mm a"
        return formatter.string(from: date)
    }
    
    
    
    @IBAction func onCalculateClick(_ sender: UIButton) {
        if(weightTextField.text!.isEmpty || heightTextField.text!.isEmpty){
            showAlert(message: "Please Enter Valid Weight and Height number.")
            return
        }
        calculateBMI()
    }
    
    func calculateBMI(){
        switch item!.mode {
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
        bmiTextField.text = String(calculateResult)
    }
    
    @IBAction func onSubmitBtnClick(_ sender: UIButton) {
        updateItem(item: item!)
    }
    
    // Update item data from coreData
    func updateItem(item: BMIItem){
        item.bmi = calculateResult
        item.weight = Float(weightTextField.text!)!
        item.height = Float(heightTextField.text!)!
        
        do {
            try context.save()
        } catch {
            // Error
        }
    }
    
    // create alert popup with error message
    func showAlert(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


}
