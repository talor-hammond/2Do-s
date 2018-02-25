//
//  MainViewController.swift
//  2Do's
//
//  Created by Talor Hammond on 15/02/18.
//  Copyright © 2018 Talor Hammond. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UIViewController {

    // shared properties:
    var itemArray = [ToDoItem]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedCategory: Category? {
        didSet { // starts when a value for optional selectedCategory has been set:
            loadItems()
        }
    }
    
    // creating a filepath for data to be saved to / access to SQLite database:
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    // MARK - outlets:
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting the ViewController as the tableView delegate / datasource:
        listTableView.delegate = self
        listTableView.dataSource = self
        
        searchBar.delegate = self
                
        // configuring the height of the tableView cells:
        configureTableView()
                
    }
    
    // MARK: Adding ToDoItem object to database...

    @IBAction func addButtonPressed(_ sender: Any) {
    
        // creating a textField variable that can be accessed throughout this func's scope:
        var textField = UITextField()
        
        // pop-up to show w textField
        let alert = UIAlertController(title: "What do you need to do?", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newItem = ToDoItem(context: self.context)
            // filling non-optional "fields"...
            newItem.title = textField.text!
            newItem.completed = false
            // assigning a category...
            newItem.parentCategory? = self.selectedCategory!
            
            // append NSManagedObject to end of itemArray [NSManagedObject]
            self.itemArray.append(newItem)
            
            // saving ToDoItem context to the database...
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
    
    // MARK: Methods for saving / loading ToDoItem object:
    
    func saveItems() {
        
        do {

            try context.save()
            
        } catch {
        
            print("Error saving context: \(error)")
            
        }
        
        // updating the listTableView content:
        listTableView.reloadData()
        
    }
    
    func loadItems(with request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest(), predicate: NSPredicate? = nil) {
        
        // loading items; filtering by selectedCategory -
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let searchPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, searchPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        do {
            // fetching all the ToDoItem objects and assigning them to itemArray:
        itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
}

// MARK: tableView methods -
extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        
        //        // accessing the NSManagedObject's context (deleted state):
        //        context.delete(itemArray[indexPath.row])
        //        itemArray.remove(at: indexPath.row)
        //        saveItems()
        
        // negating the permanent highlight:
        listTableView.deselectRow(at: indexPath, animated: true)
        
        // editing "title" value:
        // TODO - edit addButtonPressed function with dynamic inputs to edit selected item.
        //        itemArray[indexPath.row].setValue(textInput, forKey: "title")
        
        // alternating the "completed" property of the Item():
        itemArray[indexPath.row].completed = !itemArray[indexPath.row].completed
        
        saveItems() // updates the changes to the property of the Item when selected.
        
    }
    
    
    // making the height of the tableView cell dynamic:
    func configureTableView() {
        
        listTableView.rowHeight = UITableViewAutomaticDimension
        listTableView.estimatedRowHeight = 100.0
        
    }

    
}

// MARK: searchBar methods -
extension ToDoListViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        // TODO: searchBar to bottom; move up with keyboard when editing begins.
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        
        // determining the predicate for the request...
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        // sorting...
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 { // when the textDidChange - & then gone down to 0:
    
            // load default request for items:
            loadItems()
            
            DispatchQueue.main.async { // assigning edit to ui into background thread:
                
                searchBar.resignFirstResponder() // ...searchBar should no longer be the selected "thing"
                
            }
            
        }
    }
    
}










