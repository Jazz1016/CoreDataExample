//
//  ViewController.swift
//  CoreDataExample
//
//  Created by James Lea on 5/4/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title                   = "CoreData To Do List"
        view.addSubview(tableView)
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.frame = view.bounds
    }
    
    private var models = [ToDoListItem]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "hello world"
        return cell
    }
    
    //Core Data
    func getAllItem() {
        do {
            models = try context.fetch(ToDoListItem.fetchRequest())
        } catch {
         //error
        }
    }
    
    func createItem(name: String) {
        let newItem         = ToDoListItem(context: context)
        newItem.name        = name
        newItem.createdAt   = Date()
        do {
            try context.save()
        } catch {
            //error
        }
    }
    
    func deleteItem(item: ToDoListItem) {
        context.delete(item)
        do {
            try context.save()
        } catch {
            //error
        }
    }
    
    func updateItem(item: ToDoListItem, newName: String) {
        item.name = newName
        do {
            try context.save()
        } catch {
            //error
        }
    }

}
