//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Martin Arellano on 7/13/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categoryArray: Results<Category>?
    
    //var categoryArray = [Category]()
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        //let category = categoryArray[indexPath.row]
        
        //cell.textLabel?.text = category.name
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added Yet"
        
        return cell
    }
    
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    
    
    
    //MARK: - Data Manipulation Methods
    
//    func saveCategories() {
//        do {
//            try context.save()
//        } catch {
//            print("Error saving context \(error)")
//        }
//
//        tableView.reloadData()
//    }
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
//    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
//        do {
//            categoryArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//    }
    
    func loadCategories() {
        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { action in
            // what will happen once the user clicks the Add Item button on the UIAlert
            
            //let newCategory = Category(context: self.context)
            //newCategory.name = textField.text!
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            //self.categoryArray.append(newCategory)
            
            //self.saveCategories()
            self.save(category: newCategory)
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}
