//
//  ViewController.swift
//  Todoey
//
//  Created by Andrew Taylor on 13/03/2018.
//  Copyright © 2018 Andrew Taylor. All rights reserved.
//

import UIKit

class ToDoListVC: UITableViewController {

    var itemArray = ["Get Milk", "Go to the gym", "Take over the world!"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK - Create table view data sources methods
    //number of rows in the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    //setting up each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text  = itemArray[indexPath.row]
        return cell
    }
    
    //MARK - Create table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items section
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new Todoy Item", message: "" , preferredStyle: .alert)

        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happend once the user clicks the add item button on the UIAlert
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
        }
        
        //adding the text field to the alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
          
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

