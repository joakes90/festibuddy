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

    var showAddItems: UIBarButtonItem = UIBarButtonItem()
    let delegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    var context: NSManagedObjectContext?
    var fetchedResultsController: NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.context = delegate.managedObjectContext
        self.showAddItems.title = "Add An Item"
        self.showAddItems.target = self
        self.showAddItems.style = UIBarButtonItemStyle.Plain
        self.showAddItems.action = "addItems"
        
        self.navigationItem.rightBarButtonItem = showAddItems
        
        fetchedResultsController = getFetchedResultController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
     
        self.slidingViewController().resetTopViewAnimated(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        if !self.slidingViewController().underLeftViewController.isKindOfClass(MenuTableViewController){
            self.slidingViewController().underLeftViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Menu") as UIViewController
        }
        self.view.addGestureRecognizer(self.slidingViewController().panGesture)
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
        let viewController: UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier("addItems")! as AddItems
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let unchecked: UIImage = UIImage(named: "unchecked.png")!
        let checked: UIImage = UIImage(named: "checked.png")!
        
        var item: Items = fetchedResultsController.objectAtIndexPath(indexPath) as Items
        
        if Bool(item.have) {
            cell.imageView?.image = checked
        }else{
            cell.imageView?.image = unchecked
        }
        
        cell.textLabel?.text = item.name

        
        
        return cell
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController!) {
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
        let managedObject: NSManagedObject = fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject
        context?.deleteObject(managedObject)
        context?.save(nil)
    }

   
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cellID = "cell"
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as UITableViewCell
        let item = fetchedResultsController.objectAtIndexPath(indexPath) as Items
        
        let unchecked: UIImage = UIImage(named: "unchecked.png")!
        let checked: UIImage = UIImage(named: "checked.png")!
        
        item.have = true
        
        context?.save(nil)
    }
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
