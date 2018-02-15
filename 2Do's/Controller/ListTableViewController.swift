//
//  ListTableViewController.swift
//  2Do's
//
//  Created by Talor Hammond on 15/02/18.
//  Copyright © 2018 Talor Hammond. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    // instance variables; within the tableView -
    let itemArray = ["Get the groceries", "Make dinner"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: tableView datasource methods:
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) // identifying each cell
        
        cell.textLabel?.text = itemArray[indexPath.row] // setting the text to each item of the array @ indexPath.row
        
        return cell
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    // MARK tableView delegate methods:
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // ...when a row is pressed (@indexPath)
        
        print(itemArray[indexPath.row])
        
        // adding a checkmark accessory when selected; removing if already .checkmark'd -
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        // deselecting the row immediately; stop the permanent highlight
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
