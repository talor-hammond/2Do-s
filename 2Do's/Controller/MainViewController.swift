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
    let itemArray = ["Apples", "Oranges", "Bananas"]
    
    // MARK - outlets:
    @IBOutlet weak var listTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setting the ViewController as the tableView delegate / datasource:
        listTableView.delegate = self
        listTableView.dataSource = self
        
        // configuring the height of the tableView cells:
        configureTableView()
        
    }
    
    // MARK - tableView DataSource Methods:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    // MARK - tableView Delegate Methods:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(itemArray[indexPath.row])
        
        // negating the permanent highlight:
        listTableView.deselectRow(at: indexPath, animated: true)
        
        // adding / removing a checkmark accessory:
        if listTableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            listTableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        }
        else {
            
            listTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
        
    }
    

    // making the height of the tableView cell dynamic:
    func configureTableView() {
        
        listTableView.rowHeight = UITableViewAutomaticDimension
        listTableView.estimatedRowHeight = 100.0
        
    }
    
    // MARK - actions:

    
}
