//
//  ViewController.swift
//  Todoey
//
//  Created by Grégory Da Silva on 23/04/2018.
//  Copyright © 2018 Grégory Da Silva. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    //Creating an array that will contain the data in the local storage
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Chat"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Chien"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Poisson"
        itemArray.append(newItem3)
        
        //Retrieve Data from local storage (defaults)
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArray = items
        }
    }

    //MARK - Tableview Datasource Methods
    // Declare the number of rows in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // Create a cell and populate it with data for each row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        //Set the title for the cell
        cell.textLabel?.text = item.title
        
        // Add accessory checkmark
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    // Row selection
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Toggle the done / not done
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //Reload the view to check or unchecked the cell
        tableView.reloadData()
        
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
            
            //Create a new Item() and set it's title
            let newItem = Item()
            newItem.title = textField.text!
            
            //Append the new item to the array
            self.itemArray.append(newItem)
            
            //Adding the data to the array defaults
            self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
            
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

