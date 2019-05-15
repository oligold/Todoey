//
//  CategpryViewController.swift
//  Todoey
//
//  Created by Olivier Goldschmidt on 5/15/19.
//  Copyright © 2019 Olivier Goldschmidt. All rights reserved.
//

import UIKit
import CoreData

class CategpryViewController: UITableViewController {
    
    var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        
    }

    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let item = categories[indexPath.row]
        cell.textLabel?.text = item.name
        
        
        return cell
    }

    
    //MARK: - Data Manipulationk
    
    func saveItems(){
        do {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            try context.save()
        }catch{
            print ("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems(request: NSFetchRequest<Category> = Category.fetchRequest()){
        //        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            categories = try context.fetch(request)
        }catch{
            print ("Error loading context \(error)")
        }
        tableView.reloadData()
    }
    //MARK: - Add New Categories
     @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "AddNew Todoey Item",message:"",preferredStyle:.alert)
        let action = UIAlertAction(title: "Add Item", style: .default)
        {(action) in
            // what will happen when user click the Add Item button on our UIAlert
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let item = Category(context: context)
            item.name = textField.text!
            self.categories.append(item)
            //            self.defaults.set(self.categories,forKey: "TodoListArray")
            self.saveItems()
            
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
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
}
