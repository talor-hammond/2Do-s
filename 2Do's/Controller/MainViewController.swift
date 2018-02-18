//
//  MainViewController.swift
//  2Do's
//
//  Created by Talor Hammond on 15/02/18.
//  Copyright © 2018 Talor Hammond. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK - instance variables:
    var itemArray = [Item]()
    let itemArrayKey = "ToDoItemArray"
    
    
    // setting a user-defaults object, defaults:
    let defaults = UserDefaults.standard
    
    // MARK - outlets:
    @IBOutlet weak var listTableView: UITableView!

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "1"
        itemArray.append(newItem)

        let newItem2 = Item()
        newItem2.title = "123"
        itemArray.append(newItem2)

        let newItem3 = Item()
        newItem3.title = "12345"
        itemArray.append(newItem3)
        
        // setting the ViewController as the tableView delegate / datasource:
        listTableView.delegate = self
        listTableView.dataSource = self
        
        // defining the itemArray with the stored data in defaults
//        if let items = (defaults.array(forKey: itemArrayKey) as? [Item]) { // assigning a constant to the array only if there is a value
//            itemArray = items
//        }
        
        // configuring the height of the tableView cells:
        configureTableView()
        
    }
    
    // MARK - tableView DataSource Methods:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // dynamic accessory type:
        cell.accessoryType = item.completed ? .checkmark : .none
        
        return cell
        
    }
    
    // MARK - tableView Delegate Methods:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(itemArray[indexPath.row])
        
        // negating the permanent highlight:
        listTableView.deselectRow(at: indexPath, animated: true)
        
        // alternating the "completed" property of the Item():
        itemArray[indexPath.row].completed = !itemArray[indexPath.row].completed
        
        tableView.reloadData()
        
    }
    

    // making the height of the tableView cell dynamic:
    func configureTableView() {
        
        listTableView.rowHeight = UITableViewAutomaticDimension
        listTableView.estimatedRowHeight = 100.0
        
    }
    
    // Adding list item...
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        // creating a textField variable that can be accessed throughout this func's scope:
        var textField = UITextField()
        
        // pop-up to show w textField
        let alert = UIAlertController(title: "What do you need to do?", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            
            // append item to end of itemArray
            self.itemArray.append(newItem)
            
            // saving to the defaults UserDefaults object:
            self.defaults.set(self.itemArray, forKey: self.itemArrayKey)
            
            // updating the listTableView content:
            self.listTableView.reloadData()
        }
        
        // adding the action to alert...
        alert.addAction(action)
        
        // adding a text-field to alert...
        alert.addTextField { (alertTextField) in
            // accessing the textField's properties:
            alertTextField.placeholder = "Create new to-do"
            textField = alertTextField
        }
        
        // presenting alert (UIAlertController) when addButtonPressed:
        present(alert, animated: true, completion: nil)
        
    }
    
    
}












