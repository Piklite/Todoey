//
//  ViewController.swift
//  Todoey
//
//  Created by Grégory Da Silva on 23/04/2018.
//  Copyright © 2018 Grégory Da Silva. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK - Tableview Datasource Methods
    // Declare the number of rows in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // Create a cell and populate it with data for each row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK - TableView Delegate Methods
    // Row selection
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Add accessory checkmark
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        // Deselect automaticly for better UI
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //Adding a global variable to extend the scope of alertTextField
        var textField = UITextField()
        
        //Create an alert (popup)
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        //Create an action (button) for the alerte popup
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //Append the new item to the array
            self.itemArray.append(textField.text!)
            
            //Reload the tableview to update the UI with the new data
            self.tableView.reloadData()
        }
        
        //Adding a text field in the alert popup
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        //Add the action to the alerte
        alert.addAction(action)
        
        //Present the alert when the + button is pressed
        present(alert, animated: true, completion: nil)
    }
    
    
    
}

