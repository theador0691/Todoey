//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Andrew Taylor on 09/04/2018.
//  Copyright © 2018 Andrew Taylor. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    var categoriesArray = [Category]()
    let defaults = UserDefaults.standard
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    //MARK: Table View Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categoriesArray[indexPath.row]
        cell.textLabel?.text  = category.name
        return cell
    }
    
    //Mark: Data Manipulation Methods
    func saveCategories(){
        do{
            try context.save()
        }catch {
            print("error saving context \(error)")
        }
    }
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        
        do{
            categoriesArray =  try context.fetch(request)
        } catch {
            print(error)
        }
        tableView.reloadData()
        
    }
    //MARK: Add Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new Todoy Item", message: "" , preferredStyle: .alert)
        var textField = UITextField()
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happend once the user clicks the add item button on the UIAlert
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            //setting up the user deftauls
            self.saveCategories()
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
            destinationVC.selectedCategory = categoriesArray[indexPath.row]
            
        }
    }
    
}
