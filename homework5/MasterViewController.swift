//
//  MasterViewController.swift
//  hw5
//
//  Created by Carlos Lemus on 2/21/17.
//  Copyright © 2017 Carlos Lemus. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    var foodNames = ["arepas", "arroz-con-pollo", "burrito", "carne-asada","carnitas","ceviche","chalupa", "chicharrones", "chile-relleno", "chili-con-carne", "churro", "cuban-sandwich", "dulce-de-leche", "empanada", "enchilada", "fajitas","flan","gordita", "guacamole", "margarita", "mexican-rice", "nachos", "paella", "quesadilla","refried","salsa", "sopaipilla","taco","tamale","tortilla"]

    
    var foods = [Foods]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        //let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
       // self.navigationItem.rightBarButtonItem = addButton
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        if let path = Bundle.main.path(forResource: "details", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                var details : [String] = data.components(separatedBy: .newlines)
                details = details.filter { $0 != "" } //filter emtpy items
                print(details)
                var counter = 1
                for name in foodNames{
                    //let descriptionIndex =  descriptions.indexOf(name)
                    self.foods.append(Foods(name: name, description: details[counter], iconName: name))
                    counter += 2
                }
            } catch {
                print(error)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(_ sender: Any)  {
        
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let food = self.foods[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = food
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foods.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let food = self.foods[indexPath.row]
        cell.imageView?.image = food.foodImage()
        cell.textLabel?.text = food.formatName()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            foods.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
}

