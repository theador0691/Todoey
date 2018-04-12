//
//  ViewController.swift
//  Todoey
//
//  Created by Andrew Taylor on 13/03/2018.
//  Copyright © 2018 Andrew Taylor. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListVC: UITableViewController {

    var todoItems: Results<Item>?
    let realm = try! Realm()
    var selectedCategory: Category? {
        didSet{
            // getting the array from the user default
             loadItems()
        }
    }
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
     //   print(dataFilePath)
     
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK - Create table view data sources methods
    //number of rows in the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    //setting up each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let item = todoItems?[indexPath.row]{
            cell.textLabel?.text  = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else{
            cell.textLabel?.text = "No items added"
        }
        return cell
    }
    
    //MARK - Create table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print(itemArray[indexPath.row])
        if let item = todoItems?[indexPath.row]{
            do{
                try realm.write {
                    item.done = !item.done
                }
            }catch {
                print("Error saving satus")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items section
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new Todoy Item", message: "" , preferredStyle: .alert)

        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //What will happend once the user clicks the add item button on the UIAlert

    
            
            if let currentCategori = self.selectedCategory {
                do{
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        currentCategori.items.append(newItem)
                    }
                }catch {
                    print("error saving context \(error)")
                }
            }
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
    

    
    func loadItems(){

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()

    }
    

}

extension ToDoListVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@" , searchBar.text).sorted(byKeyPath: "title", ascending: true)
        
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        loadItems(with: request, predicate: predicate )
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

