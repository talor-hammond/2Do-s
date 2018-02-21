//
//  CategoryViewController.swift
//  2Do's
//
//  Created by Talor Hammond on 22/02/18.
//  Copyright © 2018 Talor Hammond. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
        
    }
    
    // MARK: Data manipulation methods -
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        // creating a textField variable that can be accessed throughout this func's scope:
        var textField = UITextField()
        
        // pop-up to show w textField
        let alert = UIAlertController(title: "Add a new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            // choosing a category name:
            newCategory.name = textField.text!
            
            // append NSManagedObject to end of categoryArray [NSManagedObject]
            self.categoryArray.append(newCategory)
            
            // saving ToDoItem context to the database...
            self.saveItems()
            
        }
        
        // adding the action to alert...
        alert.addAction(action)
        
        // adding a text-field to alert...
        alert.addTextField { (alertTextField) in
            // accessing the textField's properties:
            alertTextField.placeholder = "School, work, etc."
            textField = alertTextField
        }
        
        // presenting alert (UIAlertController) when addButtonPressed:
        present(alert, animated: true, completion: nil)

    }
    
}

// MARK: tableView delegate / dataSource methods -
extension CategoryViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name

        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray.count
        
    }
    
    // MARK: Methods for saving / loading ToDoItem object:
    
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
        
        // updating content:
        tableView.reloadData()
        
    }
    
    func loadItems(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            // fetching all the ToDoItem objects and assigning them to categoryArray:
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
}






















