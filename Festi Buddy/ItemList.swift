//
//  itemList.swift
//  Festi Countdown
//
//  Created by Justin Oakes on 2/1/15.
//  Copyright (c) 2015 Justin Oakes. All rights reserved.
//

import UIKit
import CoreData
class ItemList: UITableViewController, NSFetchedResultsControllerDelegate {

    let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var context: NSManagedObjectContext?
    var fetchedResultsController: NSFetchedResultsController = NSFetchedResultsController()
    var closed: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.context = delegate.managedObjectContext
        
        fetchedResultsController = getFetchedResultController()
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch _ {
        }
     
        self.slidingViewController().resetTopViewAnimated(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        if !self.slidingViewController().underLeftViewController.isKindOfClass(MenuTableViewController){
            self.slidingViewController().underLeftViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Menu")
        }
            }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return fetchedResultsController.sections!.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return fetchedResultsController.sections![section].numberOfObjects
    }

    
    func addItems() {
        let viewController: UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier("addItems") as! AddItems
        self.showViewController(viewController, sender: self)
        
    }
    
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: itemFetchRequest(), managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }
    
    func itemFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Items")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) 
        let unchecked: UIImage = UIImage(named: "unchecked.png")!
        let checked: UIImage = UIImage(named: "checked.png")!
        
        let item: Items = fetchedResultsController.objectAtIndexPath(indexPath) as! Items
        
        if Bool(item.have) {
            cell.imageView?.image = checked
        }else{
            cell.imageView?.image = unchecked
        }
        
        cell.textLabel?.text = item.name

        
        
        return cell
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let managedObject: NSManagedObject = fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        context?.deleteObject(managedObject)
        do {
            try context?.save()
        } catch _ {
        }
    }

   
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = fetchedResultsController.objectAtIndexPath(indexPath) as! Items
        
        item.have = true
        
        do {
            try context?.save()
        } catch _ {
        }
    }
    
    @IBAction func showMenu(){
        if self.closed {
            self.slidingViewController().anchorTopViewToRightAnimated(true)
            self.closed = false
        } else{
            self.slidingViewController().resetTopViewAnimated(true)
            self.closed = true
        }
    }

}
