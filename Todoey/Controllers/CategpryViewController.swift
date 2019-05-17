//
//  CategpryViewController.swift
//  Todoey
//
//  Created by Olivier Goldschmidt on 5/15/19.
//  Copyright © 2019 Olivier Goldschmidt. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift

class CategpryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        
    }

    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added"
        
        
        return cell
    }

    
    //MARK: - Data Manipulationk
    
    func save(category: Category){
        do {
            try realm.write{
                realm.add(category)
            }
        }catch{
            print ("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems(){
        
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    //MARK: - Add New Categories
     @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "AddNew Todoey Item",message:"",preferredStyle:.alert)
        let action = UIAlertAction(title: "Add Item", style: .default)
        {(action) in
            // what will happen when user click the Add Item button on our UIAlert
//            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let item = Category()
            item.name = textField.text!
            self.save(category: item)
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
            
        }
        alert.addAction(action)
        present(alert,animated: true,completion:nil)
        
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
}
