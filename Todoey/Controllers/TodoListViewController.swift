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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Retrieve Data from local storage
        loadItems()
    }

    
    
    
    //MARK - Tableview Datasource Methods
    // **********************************************************************
    
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
    // **********************************************************************
    
    // Did select a row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Toggle the done / not done
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.reloadData()
        
        // Deselect automaticly for better UI
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    //MARK - Add New Items
    // **********************************************************************
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //Adding a global variable to extend the scope of alertTextField
        var textField = UITextField()
        
        //Create an alert (popup)
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        //Adding a text field in the alert popup
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        //Create an action (button) for the alerte popup
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //Create a new Item() object and set it's title
            let newItem = Item()
            newItem.title = textField.text!
            
            //Append the new item to the array
            self.itemArray.append(newItem)
            
            self.saveItems()
            
            //Reload the tableview to update the UI with the new data
            self.tableView.reloadData()
        }
        
        //Add the action to the alert
        alert.addAction(action)
        
        //Present the alert when the + button is pressed
        present(alert, animated: true, completion: nil)
    }
    
    
    //Mark - Model Manipulation Methods
    // **********************************************************************
    
    //Encode and store the data
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding array = \(error)")
        }
    }
    
    //Decode the data
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding array = \(error)")
            }
        }
    }
    
    
}

