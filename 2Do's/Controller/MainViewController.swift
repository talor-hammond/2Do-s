//
//  MainViewController.swift
//  2Do's
//
//  Created by Talor Hammond on 15/02/18.
//  Copyright © 2018 Talor Hammond. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var itemArray = [Item]()
    let itemArrayKey = "ToDoItemArray"
    
    // creating a filepath for data to be saved to:
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist") // appending the path with a new component.
    
    // MARK - outlets:
    @IBOutlet weak var listTableView: UITableView!

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting the ViewController as the tableView delegate / datasource:
        listTableView.delegate = self
        listTableView.dataSource = self
                
        // configuring the height of the tableView cells:
        configureTableView()
        
        // TODO: append the itemArray with data pulled from library
        loadItems()
        
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
        
        saveItems() // updates the changes to the property of the Item when selected.
        
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
            
            self.saveItems()
            
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
    
    // saveItems & reloadData method:
    func saveItems() {
        
        // creating an encoder object:
        let encoder = PropertyListEncoder()
        
        // encoding data...
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array -- \(error)")
        }
        
        // updating the listTableView content:
        listTableView.reloadData()
        
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) { // optional binding:
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Failed to decode data, \(error)")
            }
        }
        
    }
    
}












