//
//  ViewController.swift
//  ToDoEy
//
//  Created by Russell King on 17/3/19.
//  Copyright © 2019 Russell King. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
          let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
  //  let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
  
        
        print(dataFilePath)
        
   /*     let newItem = Item()
        newItem.Title = "Ring Kate"
        itemArray.append(newItem)
       
        let newItem2 = Item()
        newItem2.Title = "Pick up Albert"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.Title = "Hug Clara"
        itemArray.append(newItem3) */
        
        loadItems()
        
     //   if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
      //      itemArray = items
     //   }
        
    }

    //Mark Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.Title
        
        cell.accessoryType = item.Done == true ? .checkmark : .none
        
        
        return cell
        
    }
    
    //Mark Tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        
        itemArray[indexPath.row].Done = !itemArray[indexPath.row].Done
        
        saveItems()
        
       // if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
       //     tableView.cellForRow(at: indexPath)?.accessoryType = .none
        //}
       // else {
       //     tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
    
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Mark Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //what will happen when the user clicks the add item button on our UIAlert
            
            let newItem = Item()
            newItem.Title = textField.text!
            
            self.itemArray.append(newItem)
            
     //       self.defaults.set(self.itemArray, forKey: "TodoListArray")
  
            self.saveItems()
    
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated:true, completion: nil)
        
        
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
             tableView.reloadData()
        
        
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
            print("Error decoding item array, \(error)")
            }
        
        
        
        
    }
    }
    
}

