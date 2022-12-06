//
//  TrackingViewController.swift
//  BMI_calculator
//
//  Created by chin wai lai on 5/12/2022.
//

import UIKit

class TrackingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var items: [BMIItem] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllItems()
    }
    
    
    // get item array from core data
    func getAllItems() {
        do {
            items = try context.fetch(BMIItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            // Error
        }
    }
    
    
    // delete item from core data
    func deleteItem(item: BMIItem){
        context.delete(item)
        
        do {
            try context.save()
            
            items = try context.fetch(BMIItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            // Error
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // init custom resuable table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! TrackingTableViewCell
        cell.set(bmi: items[indexPath.row].bmi, weight: items[indexPath.row].weight, height: items[indexPath.row].height, date: items[indexPath.row].date!)
        return cell
    }
    
    
    // left swipe action (delete)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            _,_,completion in
            let item = self.items[indexPath.row]
            self.deleteItem(item: item)
            // delete on the database
            completion(true)
        }
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }
    
    // right swipe action
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") {
            _,_,completion in
            let item = self.items[indexPath.row]
            self.performSegue(withIdentifier: "goToEditView", sender: item)
            completion(true)
        }
        let config = UISwipeActionsConfiguration(actions: [editAction])
        return config
    }

    // passing selected BMI Item to detailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as? DetailViewController
        let item = sender as! BMIItem
        dvc?.item = item
    }
    
    
    
}
