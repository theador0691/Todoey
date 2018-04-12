//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Andrew Taylor on 09/04/2018.
//  Copyright © 2018 Andrew Taylor. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {

    let realm = try! Realm()
    
    var categories: Results<Category>?
    let defaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    //MARK: Table View Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

        cell.textLabel?.text  = categories?[indexPath.row].name ?? "No Categories Added Yet"
        return cell
    }
    
    //Mark: Data Manipulation Methods
    func saveCategories(category: Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }catch {
            print("error saving context \(error)")
        }
    }
    func loadCategories(){
         categories = realm.objects(Category.self)
        
        tableView.reloadData()
    
    }
    //MARK: Add Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new Category", message: "" , preferredStyle: .alert)
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //What will happend once the user clicks the add item button on the UIAlert
            let newCategory = Category()
            newCategory.name = textField.text!

            self.saveCategories(category: newCategory)
            self.loadCategories()
            self.tableView.reloadData()
        }
        
        alert.addAction(action)

        //adding the text field to the alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
    
    
    //Mark: Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationVC = segue.destination as! ToDoListVC
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row]
            
        }
    }
    
}
