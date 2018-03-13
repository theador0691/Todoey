//
//  ViewController.swift
//  Todoey
//
//  Created by Andrew Taylor on 13/03/2018.
//  Copyright © 2018 Andrew Taylor. All rights reserved.
//

import UIKit

class ToDoListVC: UITableViewController {

    let itemArray = ["Get Milk", "Go to the gym", "Take over the world!"]
    
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
    
}

