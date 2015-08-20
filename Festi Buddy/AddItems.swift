//
//  AddItemsTableViewController.swift
//  Festi Countdown
//
//  Created by Justin Oakes on 1/31/15.
//  Copyright (c) 2015 Justin Oakes. All rights reserved.
//

import UIKit
import CoreData

class AddItems: UITableViewController {

    let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var context: NSManagedObjectContext?

    var tableItems: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.context = delegate.managedObjectContext
        
        let itemsPath = NSBundle.mainBundle().pathForResource("packinglist", ofType: "plist")
        self.tableItems = NSArray(contentsOfFile: itemsPath!)!
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be  =
        
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return tableItems.count + 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        if indexPath.row == 0{
            cell.textLabel?.text = "Create a new item to add"
            cell.imageView?.image = nil
            return cell
        } else {
            let title: String = self.tableItems[indexPath.row - 1] as! String
            let plusImage: UIImage = UIImage(named: "plusbutton.png")!
            let minusImage: UIImage = UIImage(named: "minusbutton.png")!
        
            if ItemsController.sharedInstance.checkForDuplicate(title) {
                cell.imageView?.image = minusImage
            } else {
                cell.imageView?.image = plusImage
            }
        
            cell.textLabel?.text = title
        }
        return cell
    }
    

    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //re write code to change the add button check if the item is already in the CD store remove it if it is add it if not
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == 0 {
            self.performSegueWithIdentifier("addStuff", sender: self)
        } else if !ItemsController.sharedInstance.checkForDuplicate(tableItems[indexPath.row - 1] as! String){
            let customItem: Items = NSEntityDescription.insertNewObjectForEntityForName("Items", inManagedObjectContext: delegate.managedObjectContext) as! Items
            customItem.name = self.tableItems[indexPath.row - 1] as! String
            customItem.have = NSNumber(bool: false)
            do {
                try delegate.managedObjectContext.save()
            } catch {
                print("failed to save object")
            }
            self.tableView.reloadData()
        } else {
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "Items")
        fetchRequest.predicate = NSPredicate(format: "name = %@", argumentArray: [tableItems[indexPath.row - 1]])
        var objectToRemove: Items?
        do {
            objectToRemove = try delegate.managedObjectContext.executeFetchRequest(fetchRequest)[0] as? Items
        } catch {
            print("failed to fetch")
        }
            delegate.managedObjectContext.deleteObject(objectToRemove!)
            self.tableView.reloadData()
        }
    }
}
